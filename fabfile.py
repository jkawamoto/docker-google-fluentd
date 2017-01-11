#pylint: skip-file
#
# fabfile.py
#
# Copyright (c) 2015-2017 Junpei Kawamoto
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#
from fabric.api import *
from fabric.contrib import files
env.use_ssh_config = True

PACKAGE = "google-fluentd"

@task
def deploy():
    """Upload contents. """
    if not files.exists(PACKAGE):
        run("mkdir " + PACKAGE)
    with cd(PACKAGE):
        put("Dockerfile", ".")
        put("conf", ".", mirror_local_mode=True)


@task
def build():
    """Build a docker image. """
    with cd(PACKAGE):
        run("docker build -t {tag} .".format(tag=PACKAGE))
