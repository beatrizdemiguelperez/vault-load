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

if [[ -z "$VAULT_PROJECT" ]]; then
    echo "Must provide VAULT_PROJECT in environment" 1>&2
    ERROR=1
fi

if [[ -z "$VAULT_TOKEN" ]]; then
    echo "Must provide VAULT_TOKEN in environment" 1>&2
    ERROR=1
fi

if [[ -z "$VAULT_ADDR" ]]; then
    echo "Must provide VAULT_ADDR in environment" 1>&2
    ERROR=1
fi

if [[ -z "$VAULT_ENV" ]]; then
    echo "Must provide -e (environment) option" 1>&2
    ERROR=1
fi

if [[ -z "$VAULT_APPLICATION" ]]; then
    echo "Must provide -a (application name) option" 1>&2
    ERROR=1
fi

if [[ -z "$SECRET_NAME" ]]; then
    echo "Must provide -s (secret name) option" 1>&2
    ERROR=1
fi

if [[ "$ERROR" == 1 ]]; then
    exit 1
fi

OUTPUT=$(curl --fail -X GET "${VAULT_ADDR}/v1/generic/project/${VAULT_PROJECT}/${VAULT_ENV}/${VAULT_APPLICATION}/${SECRET_NAME}" -H "X-Vault-Token: ${VAULT_TOKEN}")
echo "$OUTPUT" | jq -r '.data.value'