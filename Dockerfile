FROM alpine:3.12

RUN apk add --no-cache python3 tzdata && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache && \
    pip install https://github.com/sffjunkie/astral/archive/1.10.1.tar.gz && \
	pip install influxdb && \
    pip install https://github.com/petermdevries/gw2pvo/releases/download/v2.0-beta6/gw2pvo-1.3.6.tar.gz

ENV GW_STATION_ID="" \
    GW_ACCOUNT="" \
    GW_PASSWORD="" \
    PVO_SYSTEM_ID="" \
    PVO_API_KEY="" \
    PVO_INTERVAL="15" \
    DARKSKY_API_KEY="" \
    LOG="info" \
    CITY="Amsterdam" \
    TZ="Europe/Amsterdam" \
	INFLUX="false" \
	INFLUX_DATABASE="influxdb" \
	INFLUX_PORT="80" \
	INFLUX_MEASUREMENT="PV" \
	INFLUX_USER="username" \
	INFLUX_PASSWORD="password"

ENTRYPOINT exec gw2pvo \
    --gw-station-id ${GW_STATION_ID} \
    --gw-account ${GW_ACCOUNT} \
    --gw-password ${GW_PASSWORD} \
    --pvo-system-id ${PVO_SYSTEM_ID} \
    --pvo-api-key ${PVO_API_KEY} \
    --pvo-interval ${PVO_INTERVAL} \
    --log ${LOG} \
    --city ${CITY} \
    --skip-offline \
    --influx ${INFLUX} \
    --influx_database ${INFLUX_DATABASE} \
    --influx_server ${INFLUX_SERVER} \
    --influx_port ${INFLUX_PORT} \
    --influx_measurement ${INFLUX_MEASUREMENT} \
    --influx_user ${INFLUX_USER} \
    --influx_password ${INFLUX_PASSWORD}
