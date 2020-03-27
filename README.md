

# Vault Load

##### Script to easily load secrets from a vault


### Prerequisites
- this script assumes you have your vault path structured like: `/v1/generic/project/${VAULT_PROJECT}/${VAULT_ENV}/${VAULT_APPLICATION}/${SECRET_NAME}`

- have the following environment variables defined:
    - `VAULT_ADDR` - the url to your vault instance
    - `VAULT_PROJECT` - the name of your vault project
    - `VAULT_TOKEN` - your vault token so you can read from the vault

### Usage
- `npm install -g vault-load`
- `... define required environment variables`
- `MY_VAULT_SECRET=$(vault_load -a <application_name> -s <secret_name> -e <env>)`