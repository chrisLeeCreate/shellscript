#!/bin/sh
#filename="/Users/lishaowei/Desktop/shell指令集/xes-online-debug.apk"
#filename="/Users/lishaowei/Desktop/shell指令集/xes-online-release.apk"
checkSize(){
    filename="$1"
    #拿到插件size
    filesize=`ls -l $filename | awk '{ print $5 }'`
    #插件额定大小
    maxsize=$((1024*1024*5))
    if [ $filesize -gt $maxsize ]
    then
        echo "$filesize > $maxsize"
        echo "插件大小不允许超过5M"
        exit
    else 
        echo "$filesize < $maxsize"
    fi
}

checkSize "/Users/lishaowei/StudioProjects/XOLXesAppAndroid/XOLXesApp/xes-online/build/outputs/apk/release/xes-online-release.apk"
echo "插件大小不允许超过5M"
echo "插件大小不允许超过5M"