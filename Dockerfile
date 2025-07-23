FROM alpine:latest

# 安装必要工具
RUN apk add --no-cache curl openssl

ENV HYSTERIA2_VERSION=2.6.2

# 下载并安装 Hysteria2
RUN curl -L -o /usr/bin/hysteria https://github.com/apernet/hysteria/releases/download/app/v${HYSTERIA2_VERSION}/hysteria-linux-amd64 \
    && chmod +x /usr/bin/hysteria

# 挂载配置文件和证书目录
VOLUME ["/etc/hysteria"]

# 拷贝启动脚本
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 443/udp
EXPOSE 443/tcp

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
