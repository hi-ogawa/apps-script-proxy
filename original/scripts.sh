#!/bin/bash

function Main() {
  case "${1}" in
    url)
      DEPLOY_ID=$(clasp deployments | tail -n 1 | cut -d ' ' -f 2)
      PROXY_URL="https://script.google.com/macros/s/${DEPLOY_ID}/exec"
      echo "${PROXY_URL}"
    ;;
    *) echo ":: Command not found > ${@}" ;;
  esac
}

Main "${@}"
