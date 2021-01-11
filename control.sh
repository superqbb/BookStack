#!/bin/bash

workspace=$(cd $(dirname $0) && pwd)
cd $workspace

pidfile=var/app.pid
logfile=var/app.log

mkdir -p var &>/dev/null

## build & pack
function build(){
    # todo
    echo "todo"
}

function pack(){
     # todo
    echo "todo"
}

function packbin(){
    # todo
    echo "todo"
}

## opt
function start(){
    # create upload file path
    if [ ! -d "logs" ];then
        mkdir -p logs
    fi
    
    check_pid
    running=$?
    if [ $running -gt 0 ];then
        echo -n "started, pid="
        cat $pidfile
        return 1
    fi

    nohup ./BookStack &> $logfile &
    echo $! > $pidfile
    echo "BookStack start ok, pid=$!"
}

function stop(){
    pid=`cat $pidfile`
    kill -9 $pid
    echo "BookStack stoped"
}

function restart(){
    stop
    sleep 1
    start
}

## other
function status(){
    check_pid
    running=$?
    if [ $running -gt 0 ];then
        echo -n "running, pid="
        cat $pidfile
    else
        echo "stoped"
    fi
}

function version(){
    #todo
    echo "todo"
}

function tailf(){
    tail -f $logfile
}

## internal
function check_pid(){
    if [ -f $pidfile ];then
        pid=`cat $pidfile`
        if [ -n $pid ]; then
            running=`ps -p $pid|grep -v "PID TTY" |wc -l`
            return $running
        fi
    fi
}

## usage
function usage(){
    echo "$0 build|pack|packbin|start|stop|restart|status|tail|version"
}

## main
action=$1
case $action in
    ## build
    "build" )
        build
        ;;
    "pack" )
        pack
        ;;
    "packbin" )
        packbin
        ;;
    ## opt
    "start" )
        start
        ;;
    "stop" )
        stop
        ;;
    "restart" )
        restart
        ;;
    ## other
    "status" )
        status
        ;;
    "version" )
        version
        ;;
    "tail" )
        tailf
        ;;
    * )
        usage
        ;;
esac