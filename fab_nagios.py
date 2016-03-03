#/bin/env python        
#-*- coding:utf-8 -*-

from fabric.api import *
from fabric.context_managers import *
from fabric.contrib.console import confirm

src_dir="/Users/gmsjy/nagios/"
nagi_dir="/opt/nagios/nagios"

env.user='nagios'
env.hosts=['114.215.184.138:10022','115.29.188.140:10022','115.29.194.125:10022']
env.password='mt5u#L9x'
#env.roledefs = {
#   'monitors':[]
#   'servers':[]
#}


@runs_once
def tar_task():
    with lcd(src_dir):
        local("tar -zcf nagios-plugin.tar.gz nagios-plugin ")

@task
def put_task():
    with settings(warn_only=True):
        result = put("/User/gmsjy/nagios/nagios-plugin.tar.gz","/opt/nagios/nagios/")
    if result.failed and not confirm("put file failed ,Continue[Y/N]"):
        abort("Aborting file put task")

@task
def check_task():
    with settings(warn_only=True):
        lmd5 = local("md5sum %s/nagios-plugin.tar.gz" % src_dir,capture =True).split(' ')[0]
        rmd5 = run("md5sum %s/nagios-plugin.tar.gz" % nagi_dir).split(' ')[0]
    if lmd5 == rmd5:
        print "OK"
    else:
        print "Error"

@task
def nrpe_start():
    run("%s/bin/nrpe -c %s/etc/nrpe.cfg -d" % (nagi_dir,nagi_dir))
    
@task
def nrpe_stop():
    run("kill `pgrep nrpe`")
    
@task
def nrpe_restart():
    nrpe_stop()
    nrpe_start()

@task 
def nrpe_check():
    nrpe_pid = run("pgrep nrpe")
    if nrpe == "":
        print "NRPE started failed!"
    else:
        print "NRPE is OK!"

@task
def plugin_update(name,dir):
    with settings(warn_only=True):
        result = put(dir+"/"+name,"~/")
    if result.failed and not confirm("put file failed ,Continue[Y/N]"):
        abort("Aborting file put task")
    with cd("~/"):
        run("chown -R nagios:nagios %s" % name)
        run("chmod 755 %s" % name)
        run("mv %s /opt/nagios/nagios/libexec/" % name)

@task 
def my_job():
    plugin_update("check_celeryworker_timeout.sh","/Users/gmsjy/work/celery/")

        
@task
def install_nrpe():
    with cd(nagi_dir):
        run("tar -zxf ./nagios-plugin.tar.gz")
        with cd(nagios-plugin):
            run("/bin/bash nrpe-install.sh")
    nrpe_start()
    nrpe_check()