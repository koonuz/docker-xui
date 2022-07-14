FROM debian:11
WORKDIR /usr/local/
COPY x-ui.sh /usr/local/x-ui.sh
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates wget tzdata runit && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget -q https://github.com/FranzKafkaYu/x-ui/releases/download/0.3.3.14/x-ui-linux-amd64.tar.gz && \
    tar -zxvf x-ui-linux-amd64.tar.gz && \
    rm x-ui-linux-amd64.tar.gz && \
    mv x-ui.sh x-ui/x-ui.sh && \
    cd x-ui && \
    chmod +x x-ui bin/xray-linux-amd64 x-ui.sh && \
    cp -f x-ui.sh /usr/bin/x-ui.sh

COPY runit /etc/service
WORKDIR /usr/local/x-ui
CMD [ "runsvdir", "-P", "/etc/service"]
