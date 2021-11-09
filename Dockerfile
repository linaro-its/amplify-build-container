FROM node:14-bullseye-slim

RUN export DEBIAN_FRONTEND=nointeractive && \
 apt-get clean -y && \
 apt-get update && \
 apt-get upgrade -y && \
 apt-get install -y locales curl unzip git

# Uncomment en_US.UTF-8 for inclusion in generation
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && \
 # Generate locale
 locale-gen && \
 apt-get --purge autoremove -y && \
 apt-get clean -y

RUN npm install -g @aws-amplify/cli && \
 npm install -g amplify-category-video && \
 curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
 unzip awscliv2.zip && \
 ./aws/install

RUN rm -rf \
 /tmp/* \
 /var/cache/* \
 /var/lib/apt/lists/* \
 /var/log/*

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

WORKDIR /srv

# COPY build_and_deploy.sh /usr/bin/
# RUN chmod a+x /usr/bin/build_and_deploy.sh
# COPY local-aws-info.json /
