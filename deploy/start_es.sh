#!/usr/bin/env bash
set -o nounset
set -o errexit

SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
REPO_DIR="$(cd -- "${SCRIPT_DIR}/../" &> /dev/null && pwd)"
DEPLOY_CONF="${SCRIPT_DIR}/deploy.conf.sh"

source "$DEPLOY_CONF"

function main() {
  # start up base services
  compose_wrapper up -d --remove-orphans -- elasticsearch kibana 

  # wait until base services are up
  compose_wrapper run -- _elasticsearch_wait_until_ready
}

main
