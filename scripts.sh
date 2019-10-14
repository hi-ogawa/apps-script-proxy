#!/bin/bash

function Main() {
  local COMMAND1="${1}"; shift
  case "${COMMAND1}" in
    all-url)
      shopt -s nullglob
      for CLONE in clone-*; do
        cd "${CLONE}"
        bash scripts.sh url
        cd - >/dev/null
      done
    ;;

    all-update)
      shopt -s nullglob
      for CLONE in clone-*; do
        cd "${CLONE}"
        cp -f ../original/{app.js,appsscript.json,scripts.sh} .
        clasp push -f
        clasp deploy
        cd - >/dev/null
      done
    ;;

    clone)
      local NAME="$(date +%s)"
      local DIR="./clone-${NAME}"
      mkdir -p $DIR
      cp -f ./original/{app.js,appsscript.json,scripts.sh} $DIR
      cd $DIR
      clasp create --title "simple-proxy-${NAME}" --type webapp
      clasp push -f
      clasp deploy
      echo ':: Execute script from the web UI and authorize application'
      clasp open
    ;;

    test)
      local VIDEO_ID="${1:-uIEw0hZfMos}"
      local TARGET="https://www.youtube.com/get_video_info?video_id=${VIDEO_ID}&gl=US&hl=en"
      local QUERY="url=$(echo "${TARGET}" | ruby -r cgi -e 'puts CGI.escape(STDIN.read.strip)')"
      local SUCCESS="0"
      local TOTAL="0"
      for BASE_URL in $(cat proxy-list.txt); do
        curl -s -L "${BASE_URL}?${QUERY}" | jq -r '.status' | grep "success" > /dev/null
        if test "${?}" = "0"; then
          echo "SUCCESS"
          SUCCESS=$(( $SUCCESS + 1 ))
        else
          echo "FAIL"
        fi
        TOTAL=$(( $TOTAL + 1 ))
      done
      echo ":: SUMMARY >> $SUCCESS/$TOTAL (SUCCESS/TOTAL) <<"
    ;;

    *) echo ":: Command not found > ${@}" ;;
  esac
}

Main "${@}"
