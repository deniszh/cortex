#!/bin/sh

cortex_data_source=$(cat <<EOF
{
  "name":"cortex",
  "type":"prometheus",
  "url":"http://frontend/api/prom/",
  "access":"proxy",
  "isDefault":true,
  "basicAuth":false
}
EOF
prom_data_source=$(cat <<XUI
{
  "name":"Prometheus",
  "type":"prometheus",
  "url":"http://prometheus:9090/",
  "access":"proxy",
  "isDefault":false,
  "basicAuth":false
}
XUI
)

until $(curl -sfo /dev/null http://grafana:3000/api/datasources); do
  # wait for grafana to boot
  sleep 1
done
curl -vX POST -d "${cortex_data_source}" -H "Content-Type: application/json" http://grafana:3000/api/datasources
curl -vX POST -d "${prom_data_source}" -H "Content-Type: application/json" http://grafana:3000/api/datasources
