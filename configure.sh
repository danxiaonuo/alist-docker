#!/bin/bash

# 创建配置文件目录
mkdir -p /opt/alist/data/
# 下载alist
curl -L -H "Cache-Control: no-cache" -o alist.tar.gz https://github.com/alist-org/alist/releases/latest/download/alist-linux-amd64.tar.gz
# 解压
tar -zxvf alist.tar.gz
# 删除源码目录
rm -f alist.tar.gz
# 将二进制文件移动到指定目录
mv alist-linux-amd64 /opt/alist/alist
# 创建配置文件
cat >/opt/alist/data/config.json <<EOF
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
    "db_file": "data.db"
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
  "temp_dir": "data/temp"
}
EOF
# 授权目录权限
chmod -R 775 /opt/alist
# 进入二进制目录
cd /opt/alist
# 运行alist
./alist -conf data/config.json -docker
