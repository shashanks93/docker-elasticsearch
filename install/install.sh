

# requirements
sed -i "s/archive.ubuntu.com/us.archive.ubuntu.com/g" /etc/apt/sources.list
apt-get update
apt-get install -y --no-install-recommends wget bzip2 vim git ca-certificates python python-dev python-django-tagging nginx uwsgi uwsgi-plugin-python python-twisted-core python-cairo-dev

# dumb-init
wget --no-check-certificate https://github.com/Yelp/dumb-init/releases/download/v1.0.1/dumb-init_1.0.1_amd64.deb
dpkg -i dumb-init_1.0.1_amd64.deb && rm dumb-init_1.0.1_amd64.deb

# Grafana
cd /opt
GRAFANA=grafana-4.3.2
#wget --no-check-certificate https://grafanarel.s3.amazonaws.com/builds/${GRAFANA}.linux-x64.tar.gz
wget --no-check-certificate https://s3-us-west-2.amazonaws.com/grafana-releases/release/${GRAFANA}.linux-x64.tar.gz
tar zxvf ${GRAFANA}.linux-x64.tar.gz
rm ${GRAFANA}.linux-x64.tar.gz
ln -s ${GRAFANA} grafana
