#
# Dockerfile
#
# Copyright (c) 2015 Junpei Kawamoto
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#
FROM reactivehub/google-fluentd-base
MAINTAINER Junpei Kawamoto <kawamoto.junpei@gmail.com>

RUN apt-get update && apt-get install -y gcc make
RUN /opt/google-fluentd/embedded/bin/gem install fluent-plugin-record-reformer \
                                                 fluent-plugin-google-cloud

# Used as tags of log records.
ENV TAG docker

# Used for adding instance_name field to each log record.
ENV INSTANCE na

ADD ./conf/*.conf /etc/google-fluentd/config.d/
