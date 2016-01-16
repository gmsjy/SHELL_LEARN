#!/bin/bash
#testhttphead.sh
#实现通过主机名，端口读取wed服务器header信息 

echo $@
echo $*
echo $0
echo $1

if(($# < 2));
then
    echo "usage:$0 host port";
    exit 1;
fi

exec 6<>/dev/tcp/$1/$2 2>/dev/null;
#打开host的PORT 可读写的Socket连接，与文件描述符6相连

if(($?!=0))；then
    echo "open $1 $2 erro!";
    exit 1;
fi
#如果打开失败，#?返回不为0，终止退出

echo -e "HEAD / HTTP/1.1\r\n\r\n" >&6;
#将HEAD信息发出给Socket

cat <&6;
#从Socket读取返回信息

exec 6<&-;
exec 6>&-;
#关闭Socket的输入输出

exit 0;

