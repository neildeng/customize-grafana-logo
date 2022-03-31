#!/bin/bash +x
set -e

# change env to you wanted
IMAGE_TAIL_CODE="customized"
GRAFANA_VERSION=8.4.2  # TESTED VERSIONS: 8.4.1、8.4.2、8.4.4
FAVICON="https://web-eshop.cdn.hinet.net/eshop/img/favicon.ico"
LOGO_ICON="https://play.grafana.org/public/img/grafana_icon.svg"
LOGO_ICON_EXTEND="svg"
APP_TITLE="Grafana"
LOGIN_TITLE="Welcom to Grafana"
GET_LOGIN_SUB_TITLE="This is sub title"

# build customize image with env
docker build -t grafana/grafana:$GRAFANA_VERSION-$IMAGE_TAIL_CODE . \
  --build-arg GRAFANA_VERSION=$GRAFANA_VERSION \
  --build-arg FAVICON="$FAVICON" \
  --build-arg LOGO_ICON="$LOGO_ICON" \
  --build-arg LOGO_ICON_EXTEND="$LOGO_ICON_EXTEND" \
  --build-arg APP_TITLE="$APP_TITLE" \
  --build-arg LOGIN_TITLE="$LOGIN_TITLE" \
  --build-arg GET_LOGIN_SUB_TITLE="$GET_LOGIN_SUB_TITLE"
  
