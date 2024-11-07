# Snowflake REST API Demo with Postman

The demo companion code for [Snowflake REST API](https://docs.snowflake.com/en/developer-guide/snowflake-rest-api/snowflake-rest-api) demo with [Postman](https://postman.com).

## Pre-requisites

- Postman and basic knowledge to work with Postman
- Snowflake Account
- Snow CLI

## Demo Sources

```shell
git clone https://github.com/Snowflake-Labs/snowflake-rest-postman-demo.git
```

## Import Postman Collections and Environment

Use the Postman [Import](https://learning.postman.com/docs/getting-started/importing-and-exporting/importing-data/) feature to import the collections from `$DEMO_HOME/collections` folder and environment `tutorial` from `$DEMO_HOME/environments` folder.

> [!IMPORTANT]
> Ensure to set the `tutorial` as **DEFAULT** environment in postman

## Environment Setup

### Snowflake 

Ensure that you have Snowflake account available and configured to be used with Snowflake CLI. 

Run the following command to ensure all set with respect to Snowflake connection,

```shell
snow connection test -c <your connection name>
```

If you have not configured your Snowflake session, please refer to this [documentation](https://docs.snowflake.com/en/developer-guide/snowflake-cli/connecting/configure-cli).

>[!TIP]
> It is very convinient to have a variable named `SNOWFLAKE_DEFAULT_CONNECTION_NAME` configured on your shell. It helps `snow` cli to use a default connection without `-c` parameter

To be able to generate `JWT` token you need to have your connection configured with [Key-Pair authentication](https://docs.snowflake.com/en/developer-guide/snowflake-cli/connecting/configure-cli). Check the [documentation](https://docs.snowflake.com/en/developer-guide/snowflake-cli/connecting/configure-cli) on how to configure KeyPair auth with the Snowflake CLI.

>[!IMPORTANT]
> Please configure your Key-Pair in encrypted mode with a private key passphrase


```shell
export SNOWFLAKE_DEFAULT_CONNECTION_NAME=trial
export PRIVATE_KEY_PASSPHRASE=<your private key passphrase>
```

Ensure you have configured all and successful run the following command to generate JWT token,

```shell
snow generate-jwt
```

### Postman

The following information are need to configure the following variables as part of Postman's `tutorial` environment:

- `snowflake_jwt_token`  - output of `snow generate-jwt -c <your connection name>`
- `snowflake_username` - the Snowflake account user login name
- `base_url` - The Snowflake Account URL. Refer <https://docs.snowflake.com/en/user-guide/admin-account-identifier>

> [!TIP]
> If you have tools like [jq](https://jqlang.github.io/jq/) then you can build your base url like
> ```shell
> snow connection test --format json | jq -r '"https://" + .Host'
> ```
> *AND*
> `snowflake_username` like 
> ```shell
> snow connection test  --format json | jq -r '.User'
> ```
> Both these commands use Snowflake connectio fomr `$SNOWFLAKE_DEFAULT_CONNECTION_NAME`

All requests are configured to have the following headers, 

- `Content-Type` is always `application/json`
- `x-snowflake-authorization-token-type` is set to use the variable `snowflake_auth_type` from the environment which is by default set to `KEYPAIR_JWT`

## Running Collections

Now you are all set to run the collections using Postman. For demonstration purpose there is some data that you can use API inside [config](./config/) folder. Please check <https://learning.postman.com/docs/collections/running-collections/working-with-data-files/> to see how to use the data with Postman.