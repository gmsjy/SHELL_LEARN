#!/bin/bash
#testhttphead.sh
#实现通过主机名，端口读取wed服务器header信息 

echo $@
echo $*
echo $0
echo $1

if (( $#<2));then
    echo "usage:$0 host port";
    exit 1;
fi

exec 6<>/dev/tcp/$1/$2 ;
#打开host的PORT 可读写的Socket连接，与文件描述符6相连

echo $2 $?

if (($?!=0));then
    echo "open $1 $2 erro!";
    echo "hini";
    exit 1;
fi
#如果打开失败，#?返回不为0，终止退出
echo "hi"

echo -e "HEAD / HTTP/1.1\n\n\n\n\n" >&6;
#将HEAD信息发出给Socket

echo $?
echo "hi"

cat <&6;
#从Socket读取返回信息

echo "Hello"

exec 6<&-;
exec 6>&-;
#关闭Socket的输入输出

exit 0;

