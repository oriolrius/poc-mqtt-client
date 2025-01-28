# Load environment variables from .env file
set dotenv-load

ssl_client:
    echo ${CA_FILE}
    openssl s_client ${MQTT_HOST}:${MQTT_PORT}

ssl_client_with_cacert:
    openssl s_client \
        -CAfile ${CA_FILE} \
        ${MQTT_HOST}:${MQTT_PORT}

ssl_client_with_cacert_and_client_cert:
    openssl s_client \
        -CAfile ${CA_FILE} \
        -cert ${CERT_FILE} \
        -key ${KEY_FILE} \
        -pass "pass:${KEY_PASSPHRASE}" \
        ${MQTT_HOST}:${MQTT_PORT}

pub +ARGS:
    mosquitto_pub \
        --cafile ${CA_FILE} \
        -d -h ${MQTT_HOST} -p ${MQTT_PORT} {{ ARGS }}

pub_with_client_certificate +ARGS: 
    mosquitto_pub \
        --cafile ${CA_FILE} \
        --cert ${CERT_FILE} \
        --key ${KEY_FILE} \
        -d -h ${MQTT_HOST} -p ${MQTT_PORT} {{ ARGS }}
