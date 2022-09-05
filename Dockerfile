##########################################
#         构建可执行二进制文件             #
##########################################
# 
# 指定创建的基础镜像
FROM danxiaonuo/alpine:latest AS builder

# 作者描述信息
MAINTAINER danxiaonuo
# 时区设置
ARG TZ=Asia/Shanghai
ENV TZ=$TZ
# 语言设置
ARG LANG=C.UTF-8
ENV LANG=$LANG

# ***** 下载二进制文件 *****
RUN set -eux && \
    export ALIST_DOWN="https://github.com/alist-org/alist/releases/latest/download/alist-linux-amd64.tar.gz" && \
    wget --no-check-certificate -O /tmp/alist.tar.gz ${ALIST_DOWN} && \
    cd /tmp && tar -zxvf alist.tar.gz && rm -f alist.tar.gz && \
    mv alist-linux-amd64 alist
# ##############################################################################

##########################################
#         构建基础镜像                    #
##########################################
# 
# 指定创建的基础镜像
FROM danxiaonuo/alpine:latest

# 作者描述信息
MAINTAINER danxiaonuo
# 时区设置
ARG TZ=Asia/Shanghai
ENV TZ=$TZ
# 语言设置
ARG LANG=C.UTF-8
ENV LANG=$LANG

# 拷贝二进制文件
COPY --from=builder /tmp/alist /usr/bin/alist

# 增加脚本
ADD configure.sh /configure.sh

# 授权脚本权限
RUN chmod +x /configure.sh

# 入口
ENTRYPOINT ["/configure.sh"]

# 运行alist
CMD ["alist","-conf","/etc/alist/config.json","-docker"]
