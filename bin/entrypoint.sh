#!/bin/bash
#
# entrypoint.sh
#
# Copyright (c) 2015-2017 Junpei Kawamoto
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#
set -e

export PATH=/sbin:/usr/sbin:/bin:/usr/bin

TD_AGENT_NAME=google-fluentd
TD_AGENT_HOME=/opt/google-fluentd
TD_AGENT_DEFAULT=/etc/default/google-fluentd
TD_AGENT_USER=root
TD_AGENT_GROUP=root
TD_AGENT_RUBY=/opt/google-fluentd/embedded/bin/ruby
TD_AGENT_BIN_FILE=/usr/sbin/google-fluentd
TD_AGENT_LOG_FILE=/var/log/google-fluentd/google-fluentd.log
TD_AGENT_OPTIONS='--use-v1-config --suppress-repeated-stacktrace'

# timeout can be overridden from /etc/default/google-fluentd
readonly STOPTIMEOUT=120

# Read configuration variable file if it is present
if [[ -f "${TD_AGENT_DEFAULT}" ]]; then
  . "${TD_AGENT_DEFAULT}"
fi

# Arguments to run the daemon with
readonly TD_AGENT_ARGS="${TD_AGENT_ARGS:-${TD_AGENT_BIN_FILE} ${TD_AGENT_OPTIONS}}"
# readonly TD_AGENT_ARGS="${TD_AGENT_ARGS:-${TD_AGENT_BIN_FILE} --log ${TD_AGENT_LOG_FILE} ${TD_AGENT_OPTIONS}}"

# Exit if the package is not installed
[[ -x "${TD_AGENT_RUBY}" ]] || exit 0

# Source function library.
# Define LSB log_* functions.
# Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
. /lib/lsb/init-functions

# Use jemalloc to avoid memory fragmentation
if [[ -f "${TD_AGENT_HOME}/embedded/lib/libjemalloc.so" ]]; then
  export LD_PRELOAD="${TD_AGENT_HOME}/embedded/lib/libjemalloc.so"
fi

if [[ $# == 0 ]]; then
  echo -n "Starting ${TD_AGENT_NAME}"
  ulimit -n 65536 1>/dev/null 2>&1 || true

  echo "exec ${TD_AGENT_RUBY} ${TD_AGENT_ARGS}"
  exec ${TD_AGENT_RUBY} ${TD_AGENT_ARGS}
else
  exec "$@"
fi
