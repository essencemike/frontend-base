FROM mhart/alpine-node

# set npm registry to taobao
# install yarn
RUN npm set registry https://registry.npm.taobao.org
RUN npm install yarn -g

# edit apk repositories
# apk upgrade
RUN sed -i -e 's/v3\.6/edge/g' /etc/apk/repositories && \
    apk upgrade --no-cache --update-cache --available

# install curl
RUN apk add curl --no-cache

# install openrc(rc-update)
RUN apk add openrc --no-cache

# install docker 
RUN apk add docker --no-cache

# add docker to boot
RUN rc-update add docker boot

# start docker service
# RUN service docker restart

# deal old Alpine Linux version or old docker version
# RUN sysctl -w kernel.grsecurity.chroot_deny_chmod=0 && \
#     sysctl -w kernel.grsecurity.chroot_deny_mknod=0

# install docker-compose
RUN apk add py-pip --no-cache && \
    pip install docker-compose

# set localtime
RUN apk add tzdata --no-cache

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  echo "Asia/Shanghai" > /etc/timezone
