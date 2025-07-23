#!/bin/sh

CERT_DIR=/etc/hysteria
CERT_FILE=${CERT_DIR}/bing.pem
KEY_FILE=${CERT_DIR}/bing.key

# 自动生成自签名证书（如果不存在）
if [ ! -f "$CERT_FILE" ] || [ ! -f "$KEY_FILE" ]; then
    echo "Generating self-signed certificate for www.bing.com ..."
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
        -keyout "$KEY_FILE" \
        -out "$CERT_FILE" \
        -subj "/CN=www.bing.com"
fi

# 启动 hysteria
exec hysteria server -c /etc/hysteria/config.yaml
