setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/testmongo
  mkdir -p $TESTDIR
  export PROJNAME=testmongo
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  printf "<?php\nphpinfo();\n" >index.php
  ddev start
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME}
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev restart
  curl -sI ${PROJNAME}.ddev.site:8081/db/admin/expArr/system.users | grep "HTTP/1.1 200 OK"
  out=$(curl -s ${PROJNAME}.ddev.site:8081/db/admin/expArr/system.users | jq -r ".[0].user")
  [ "${out}" = "db" ]
  (ddev exec php -i | grep mongodb.debug) || (echo "# php mongodb extension not found" >&3 || exit 1)
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get drud/ddev-mongo with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get drud/ddev-mongo
  ddev restart
  curl -sI ${PROJNAME}.ddev.site:8081/db/admin/expArr/system.users | grep "HTTP/1.1 200 OK"
  out=$(curl -s ${PROJNAME}.ddev.site:8081/db/admin/expArr/system.users | jq -r ".[0].user")
  [ "${out}" = "db" ]
  (ddev exec php -i | grep mongodb.debug) || (echo "# php mongodb extension not found" >&3 || exit 1)
}
