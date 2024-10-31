setup() {
  set -eu -o pipefail
  brew_prefix=$(brew --prefix)
  load "${brew_prefix}/lib/bats-support/load.bash"
  load "${brew_prefix}/lib/bats-assert/load.bash"
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/testmongo
  mkdir -p $TESTDIR
  export PROJNAME=testmongo
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME} >/dev/null
  printf "<?php\nphpinfo();\n" >index.php
  ddev start -y >/dev/null
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

health_checks() {
  set +u # bats-assert has unset variables so turn off unset check
  # ddev restart is required because we have done `ddev add-on get` on a new service
  run ddev restart
  assert_success
  curl -sI ${PROJNAME}.ddev.site:9091/db/admin/expArr/system.users | grep "HTTP/1.1 200 OK"
  out=$(curl -s ${PROJNAME}.ddev.site:9091/db/admin/expArr/system.users | jq -r ".[0].user")
  [ "${out}" = "db" ]
  (ddev exec php -i | grep mongodb.debug) || (echo "# php mongodb extension not found" >&3 || exit 1)
  # Test mongosh
  result=$(ddev mongosh "mongodb://db:db@mongo:27017/test?authSource=admin" --quiet --eval '"printjson(db.getUsers())"' --json | grep "ok" | sed 's/: 1/ /g' | sed 's/ //g' | tr ' \n' '#')
  if [[ $result == "ok#" ]]
    then
      echo "# Mongosh OK" >&3
    else
      echo "# Mongosh KO"
      echo "$result"
      exit 1
  fi
  # Make sure `ddev mongo-express` works
  DDEV_DEBUG=true run ddev mongo-express
  assert_success
  assert_output --partial "FULLURL https://${PROJNAME}.ddev.site:9092"
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev add-on get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev add-on get ${DIR} >/dev/null
  health_checks
}

# bats test_tags=release
@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev add-on get ddev/ddev-mongo with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev add-on get ddev/ddev-mongo >/dev/null
  health_checks
}
