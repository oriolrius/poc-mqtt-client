# Proof of Concept of an MQTT client with client and server certificates

Just a set of proof of concept scripts to test the connection to an MQTT broker using SSL/TLS with client and server certificates.

## Requirements

- `git` for cloning the repository
- `just` for running everything magically

## Install `uv`

```bash
just install_uv
```

## Clone the repository

```bash
git clone https://github.com/oriolrius/poc-mqtt-client.git
```

## Confguration

There is a sample `.env` file at `env.sample` and you can copy it to `.env` and edit the values to match your configuration.

```bash
copy env.sample .env
```

The `.env` will be used by `just` and the python scripts to get the configuration values.

Sample `.env` file:

```bash
# MQTT Broker Configuration
MQTT_HOST=mqtt.ymbihq.local
MQTT_PORT=8883

# SSL/TLS Configuration
CA_FILE=certs/ca.crt
CERT_FILE=certs/the_client_username.crt
KEY_FILE=certs/the_client_username.key
KEY_PASSPHRASE=your_private_key_passphrase_here
```

## Install python dependencies

Assuming you're in the root of the repository and `just` is installed:

```bash
just sync
```

## Testing the SSL connection

The initial check will fail with a self-signed certificate, but you can test the connection with the following command:

```bash
just ssl_client
```

then the same command but using the your CA certificate:

```bash
just ssl_client_with_cacert
```

another test is using a client certificate and the CA certificate:

```bash
just ssl_client_with_cacert_and_client_cert
```

## Checking with the `mosquitto_sub` and `mosquitto_pub` commands

You can use the `mosquitto_sub` and `mosquitto_pub` commands to check the connection to the MQTT broker. But it doesn't support passphrase protected keys for the client, the passphrase must be removed from the key file. Or, you can provide the passphrase interactively when the command is executed.

### Self-signed certificates in the server side

Start the subscriber with the following command:

```bash
just sub_with_cacert -t the_topic
```

and in another terminal:

```bash
just pub_with_cacert -t the_topic -m "the_message"
```

### Using client certificates

Start the subscriber with the following command:

```bash
just sub_with_client_certificate -t the_topic
```

and in another terminal:

```bash
just pub_with_client_certificate -t the_topic -m "the_message"
```

### Using Let's Encrypt certificates in the server

Start the subscriber with the following command:

```bash
just sub_letsencrypt -t the_topic
```

and in another terminal:

```bash
just pub_letsencrypt -t the_topic -m "the_message"
```

## Running the MQTT client based on the python scripts

You can run the MQTT client with the following command:

```bash
just py_sub
```

and in another terminal:

```bash
just py_pub
```

## Author

Oriol Rius <https://oriolrius.cat>

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
