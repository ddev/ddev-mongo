setup() {
  set -eu -o pipefail
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

#teardown() {
  #set -eu -o pipefail
  #cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  #ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  #[ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
#}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR} >/dev/null
  ddev restart >/dev/null
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
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get ddev/ddev-mongo with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ddev/ddev-mongo >/dev/null
  ddev restart >/dev/null
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
}
