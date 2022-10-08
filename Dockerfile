# FROM ghcr.io/pterodactyl/yolks:debian
FROM --platform=$TARGETOS/$TARGETARCH debian:buster-slim

LABEL author="VirtualBrightPlayz" maintainer="virtualbrightplayz@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

#####################
#PUPPETEER RECIPE
#####################
RUN apt-get update && apt-get -f install && apt-get -y install wget gnupg2 apt-utils
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list
RUN apt-get update \
&& apt-get install -y google-chrome-stable --no-install-recommends --allow-downgrades fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf
######################
#END PUPPETEER RECIPE
######################

# RUN     apt update -y
# RUN     dpkg --add-architecture i386
RUN apt update
RUN apt install -y wget net-tools iproute2 gnupg2 xvfb pulseaudio apt-transport-https

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
