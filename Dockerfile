FROM python:3.8.5-slim

# ARG GIT_REPO='https://github.com/jerrymakesjelly/autoremove-torrents.git'
# ARG BRANCH='master'

WORKDIR /app

# RUN apt-get update \
# && apt-get install git gcc cron -y -q \
# && git clone $GIT_REPO && cd autoremove-torrents && git checkout $BRANCH && python3 setup.py install \
# && apt-get purge gcc git -y \
# && apt-get clean

RUN apt-get update && apt-get install cron -y -q && pip install autoremove-torrents

ADD cron.sh /usr/bin/cron.sh
RUN chmod +x /usr/bin/cron.sh

RUN touch /var/log/autoremove-torrents.log

COPY config.example.yml config.yml

ENV OPTS '-c /app/config.yml'
ENV CRON '*/5 * * * *'

ENTRYPOINT ["/bin/sh", "/usr/bin/cron.sh"]