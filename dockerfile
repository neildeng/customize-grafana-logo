ARG GRAFANA_VERSION

FROM grafana/grafana:$GRAFANA_VERSION

ARG FAVICON
ARG LOGO_ICON
ARG APP_TITLE="Grafana"
ARG LOGIN_TITLE="Welcome to Grafana"
ARG GET_LOGIN_SUB_TITLE=""
ARG LOGO_ICON_EXTEND="svg"

USER root

RUN echo "Start wget images" && \
    wget $FAVICON -O /usr/share/grafana/public/img/fav32.png && \
    wget -c $LOGO_ICON -O /usr/share/grafana/public/img/customized_service_icon.$LOGO_ICON_EXTEND && \
    echo "DONE"

RUN cd /usr/share/grafana/ && \
    found_count=$(find ./ -name "*.js" -exec grep -li """AppTitle""," {} \; | wc -l) && \
    if [[ ! "${found_count}" == "1" ]]; then echo "Not Found Target File."; exit 1; fi && \
    found=$(find ./ -name "*.js" -exec grep -li """AppTitle""," {} \;) && \
    find public/views/index.html | xargs -i sed -i "s/\[\[.AppTitle\]\]/$APP_TITLE/g" {} && \
    find ${found} | xargs -i sed -i "s/\"AppTitle\",\"Grafana\"/\"AppTitle\",\""$APP_TITLE"\"/g" {} && \
    find ${found} | xargs -i sed -i "s/\"LoginTitle\",\"Welcome to Grafana\"/\"LoginTitle\",\"$LOGIN_TITLE\"/g" {} && \
    find ${found} | xargs -i sed -i "s/\"GetLoginSubTitle\",(()=>null)/\"GetLoginSubTitle\",(()=>{return \"$GET_LOGIN_SUB_TITLE\";})/g" {} && \
    find ${found} | xargs -i sed -i "s/grafana_icon.svg/customized_service_icon.$LOGO_ICON_EXTEND/g" {} && \
    echo "DONE"

USER grafana
