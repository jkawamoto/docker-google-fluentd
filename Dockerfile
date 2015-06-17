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

RUN /opt/google-fluentd/embedded/bin/gem install fluent-plugin-record-reformer \
                                                 fluent-plugin-google-cloud


ENV TAG docker

ADD ./conf/*.conf /etc/google-fluentd/config.d/
