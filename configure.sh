#!/bin/bash

# 创建配置文件目录
mkdir -p /opt/alist/data/temp /etc/alist/

# 创建配置文件
cat >/etc/alist/config.json <<EOF
{
  "address": "0.0.0.0",
  "port": $PORT,
  "assets": "$IASSETS",
  "database": {
    "type": "$ADATABASE",
    "user": "$BSQLUSER",
    "password": "$CSQLPASSWORD",
    "host": "$DSQLHOST",
    "port": $ESQLPORT,
    "name": "$FSQLNAME",
    "table_prefix": "x_",
    "db_file": "/opt/alist/data/data.db"
  },
  "scheme": {
    "https": false,
    "cert_file": "",
    "key_file": ""
  },
  "cache": {
    "expiration": $GEXPIRATION,
    "cleanup_interval": $HCLEANUP_INTERVAL
  },
  "temp_dir": "/opt/alist/data/temp"
}
EOF

# 授权目录权限
chmod -R 775 /usr/bin/alist /opt/alist
