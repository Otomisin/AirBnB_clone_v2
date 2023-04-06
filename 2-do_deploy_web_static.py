#!/usr/bin/env python3

"""
Fabric script to deploy web static content to web servers
"""
 
from fabric.api import env, put, run
from os.path import exists
import os
 
env.hosts = ['18.209.152.209', '34.207.156.104']
 
 
def do_deploy(archive_path):
    """
    Deploys an archive to the web servers
    """
    if not exists(archive_path):
        return False
 
    # Get the file name without the extension at the end
    archive_name = os.path.basename(archive_path)
    archive_name_no_ext = os.path.splitext(archive_name)[0]
 
    try:
        # Upload archive to the temporary folder
        put(archive_path, "/tmp/")
 
        # Create the directory to deploy the code
        run("mkdir -p /data/web_static/releases/{}/".format(archive_name_no_ext))
 
        # Uncompress the archive into the deployment folder
        run("tar -xzf /tmp/{} -C /data/web_static/releases/{}/"
            .format(archive_name, archive_name_no_ext))
 
        # Remove the archive
        run("rm /tmp/{}".format(archive_name))
 
        # Move files to a new folder and delete the old symbolic link
        run("mv /data/web_static/releases/{}/web_static/* \
            /data/web_static/releases/{}/".format(archive_name_no_ext, archive_name_no_ext))
        run("rm -rf /data/web_static/releases/{}/web_static".format(archive_name_no_ext))
 
        # Delete the old symbolic link and create a new symbolic link
        run("rm -rf /data/web_static/current")
        run("ln -s /data/web_static/releases/{}/ /data/web_static/current".format(archive_name_no_ext))
 
        return True
 
    except:
        return False