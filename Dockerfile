FROM debian:11-slim
COPY x-ui.sh /usr/local/x-ui.sh
ENV GET_VERSION 0.3.3.15-0724
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends ca-certificates wget runit && \
    apt-get clean && \
    cd /usr/local && \
    wget -q https://github.com/FranzKafkaYu/x-ui/releases/download/${GET_VERSION}/x-ui-linux-amd64.tar.gz && \
    tar -zxvf x-ui-linux-amd64.tar.gz && \
    rm x-ui-linux-amd64.tar.gz && \
    mv x-ui.sh x-ui/x-ui.sh && \
    chmod +x x-ui/x-ui x-ui/bin/xray-linux-amd64 x-ui/x-ui.sh && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY runit /etc/service
RUN chmod +x /etc/service/x-ui/run
WORKDIR /usr/local/x-ui
CMD [ "runsvdir", "-P", "/etc/service"]
