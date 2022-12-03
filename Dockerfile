##########################################
#         构建可执行二进制文件             #
##########################################
# 
# 指定创建的基础镜像
FROM danxiaonuo/ubuntu:latest AS builder

# 作者描述信息
MAINTAINER danxiaonuo
# 时区设置
ARG TZ=Asia/Shanghai
ENV TZ=$TZ
# 语言设置
ARG LANG=zh_CN.UTF-8
ENV LANG=$LANG

# ***** 下载二进制文件 *****
RUN set -eux && \
    export ALIST_DOWN="https://down.xiaonuo.live?url=https://github.com/alist-org/alist/releases/latest/download/alist-linux-amd64.tar.gz" && \
    wget --no-check-certificate -O /tmp/alist.tar.gz ${ALIST_DOWN} && \
    cd /tmp && tar -zxvf alist.tar.gz && mv alist-linux-amd64 alist && \
    rm -rf alist.tar.gz
# ##############################################################################

##########################################
#         构建基础镜像                    #
##########################################
# 
# 指定创建的基础镜像
FROM danxiaonuo/ubuntu:latest

# 作者描述信息
MAINTAINER danxiaonuo
# 时区设置
ARG TZ=Asia/Shanghai
ENV TZ=$TZ
# 语言设置
ARG LANG=zh_CN.UTF-8
ENV LANG=$LANG

# 拷贝二进制文件
COPY --from=builder /tmp/alist /usr/bin/alist

# 增加脚本
ADD configure.sh /configure.sh

# 授权权限
RUN chmod +x /configure.sh /usr/bin/alist

# 设置环境变量
ENV PATH /usr/bin/alist:$PATH

# 容器信号处理
STOPSIGNAL SIGQUIT

# 入口
ENTRYPOINT ["/configure.sh"]
