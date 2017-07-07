FROM ubuntu:16.04

MAINTAINER shashanks93 <shashank.pathak7793@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm-256color
ENV GRAPHITE_VERSION 0.9.15

RUN apt-get update
RUN apt-get install git -y

COPY install/. /root/.
RUN /root/install.sh

WORKDIR /opt

RUN rm -rf /opt/grafana/conf/defaults.ini
ADD grafana_ini/defaults.ini /opt/grafana/conf/defaults.ini

ADD nginx/graphite /etc/nginx/sites-available/graphite
ADD uwsgi/graphite.ini /etc/uwsgi/apps-available/graphite.ini
RUN ln -s /etc/nginx/sites-available/graphite /etc/nginx/sites-enabled && \
    ln -s /etc/uwsgi/apps-available/graphite.ini /etc/uwsgi/apps-enabled && \
    chown -R www-data:www-data /opt/graphite/storage && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

EXPOSE 2003 2004 8080 3000

VOLUME /opt/graphite

COPY init/init.sh /usr/bin/init.sh
CMD /usr/bin/init.sh
