#!/bin/sh
#author xesapp
name="开始构建"
filename="app.apk"
#删除so的白名单
so_file_array=(liblbs.so libmsc.so libijksdl.so)
echo "要删除的so文件有:"${so_file_array[*]}
for armFile in middle/lib/*
do
    for soFile in $armFile/*
    do
        for delSo in ${so_file_array[*]}
        do
            result=$(echo $soFile | grep "$delSo")
            if [[ "$result" != "" ]]
            then
            echo "删除: "$soFile
            rm -rf $soFile
            fi
        done 
    done
done
echo "删除完成"
