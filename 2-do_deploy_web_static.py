#!/usr/bin/python3
"""
    a script to send an archive file to a remote server
    and decompress it
"""

from fabric.api import run, env, put
from os.path import isfile
import os

env.hosts = ['18.209.152.209', '34.207.156.104']
env.key_filename = "~/.ssh/school"
env.user = "ubuntu"


def do_deploy(archive_path):
    """
        a function to deploy code and decompress it
    """
    if not isfile(archive_path):
        return False

    filename = os.path.basename(archive_path)
    no_ext = os.path.splitext(filename)[0]
    dest_path = '/data/web_static/releases/{}/'.format(no_ext)
    symlink_path = '/data/web_static/current'

    try:
        put(archive_path, '/tmp')
        run('sudo mkdir -p {}'.format(dest_path))
        run('sudo tar -xzf /tmp/{} -C {}'.format(filename, dest_path))
        run('sudo rm /tmp/{}'.format(filename))
        run('sudo mv {}/web_static/* {}'.format(dest_path, dest_path))
        run('sudo rm -rf {}/web_static'.format(dest_path))
        run('sudo rm -rf {}'.format(symlink_path))
        run('sudo ln -s {} {}'.format(dest_path, symlink_path))
        return True
    except Exception as e:
        print(e)
        return False
