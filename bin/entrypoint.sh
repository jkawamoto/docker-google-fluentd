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

if [[ $# == 0 ]]; then
  service google-fluentd start
  tail -f /var/log/google-fluentd/google-fluentd.log
else
  exec $@
fi
