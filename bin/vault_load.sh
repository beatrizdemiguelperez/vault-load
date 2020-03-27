#!/usr/bin/env bash

set -e
while getopts ":e:s:a:" opt; do
  case ${opt} in
  e) # process option e
    VAULT_ENV="$OPTARG"
    ;;
  s) # process option s
    SECRET_NAME="$OPTARG"
    ;;
  a) # process option a (the name of the application, hermes for example)
    VAULT_APPLICATION="$OPTARG"
    ;;
  \?)
    echo "Usage: ./vault_load.sh -s <secret_name> -e <environment_name>" && exit 1
    ;;
  esac
done

OUTPUT=$(curl --fail -X GET "${VAULT_ADDR}/v1/generic/project/${VAULT_PROJECT}/${VAULT_ENV}/${VAULT_APPLICATION}/${SECRET_NAME}" -H "X-Vault-Token: ${VAULT_TOKEN}")
echo "$OUTPUT" | jq -r '.data.value'