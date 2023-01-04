#!/bin/bash

# 创建配置文件目录
mkdir -p ${ALIST_PATH}

# 授权目录权限
chmod -R 775 /usr/bin/alist ${ALIST_PATH}
chown -R ${PUID}:${PGID} /usr/bin/alist ${ALIST_PATH}
umask ${UMASK}

# 运行alist
alist --data $ALIST_PATH server --no-prefix
