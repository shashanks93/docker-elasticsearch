

# requirements
sed -i "s/archive.ubuntu.com/us.archive.ubuntu.com/g" /etc/apt/sources.list
apt-get update
apt-get install -y --no-install-recommends wget bzip2 vim git ca-certificates python python-dev python-django-tagging nginx uwsgi uwsgi-plugin-python python-twisted-core python-cairo-dev

# dumb-init
wget --no-check-certificate https://github.com/Yelp/dumb-init/releases/download/v1.0.1/dumb-init_1.0.1_amd64.deb
dpkg -i dumb-init_1.0.1_amd64.deb && rm dumb-init_1.0.1_amd64.deb

# Grafana
cd /opt
GRAFANA=grafana-4.0.2-1481203731
wget --no-check-certificate https://grafanarel.s3.amazonaws.com/builds/${GRAFANA}.linux-x64.tar.gz
tar zxvf ${GRAFANA}.linux-x64.tar.gz
rm ${GRAFANA}.linux-x64.tar.gz
ln -s ${GRAFANA} grafana

# Graphite
cd /root
wget https://pypi.python.org/packages/ad/30/5ab2298c902ac92fdf649cc07d1b7d491a241c5cac8be84dd84464db7d8b/pytz-2016.4.tar.gz#md5=a3316cf3842ed0375ba5931914239d97
tar -zxvf pytz-2016.4.tar.gz
rm pytz-2016.4.tar.gz
cd /root/pytz-2016.4
python setup.py install

cd /root
git clone https://github.com/graphite-project/whisper.git /root/whisper
cd /root/whisper
git checkout ${GRAPHITE_VERSION}
python setup.py install

git clone https://github.com/graphite-project/carbon.git /root/carbon
cd /root/carbon
git checkout ${GRAPHITE_VERSION}
python setup.py install

git clone https://github.com/graphite-project/graphite-web.git /root/graphite-web
cd /root/graphite-web
git checkout ${GRAPHITE_VERSION}
python setup.py install

cd /opt/graphite/webapp/graphite
python manage.py syncdb --noinput
cp /opt/graphite/conf/carbon.conf.example /opt/graphite/conf/carbon.conf
cp /opt/graphite/conf/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf
