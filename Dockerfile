#
# Dockerfile
#
# Copyright (c) 2015 Junpei Kawamoto
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#
FROM ubuntu:latest
MAINTAINER Junpei Kawamoto <kawamoto.junpei@gmail.com>

RUN apt-get update && apt-get install -y curl
RUN curl -L https://storage.googleapis.com/signals-agents/logging/google-fluentd-install.sh | bash \
    && service google-fluentd stop
RUN /opt/google-fluentd/embedded/bin/gem install fluent-plugin-record-reformer

# Used as tags of log records.
ENV TAG docker

# Used for adding instance_name field to each log record.
ENV INSTANCE na

# Used for adding username field to each log record.
ENV USERNAME na

RUN rm /etc/google-fluentd/config.d/*.conf
ADD ./conf/*.conf /etc/google-fluentd/config.d/
ADD ./bin/entrypoint.sh /root/

ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["google-fluentd"]
