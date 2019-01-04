#!/bin/sh
#author lsw
name="开始构建"
filename="app.apk"


echo "要删除的so文件有:"${so_file_array[*]}
for dir in $( ls apk/)
do
	filename=$dir
	echo "$filename"
done
echo "$name"
echo "开始解压安装包"
java -jar tools/apktool.jar d -f apk/"$filename" -o middle
echo "安装包解压完成"
echo "开始打包"
channelkey="Android"


rm output/new.apk
rm output/${1}.apk
#sed -ig "s/android:value=\"$channelkey\"/android:value=\"$line\"/g"  middle/AndroidManifest.xml
for armFile in middle/lib/*
do
    for soFile in $armFile/*
    do
        for delSo in $(<so_list)
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
echo "删除so文件完成"

#再次打包
java -jar tools/apktool.jar b  middle -o output/new.apk
echo "签名安装包"
jarsigner -verbose -keystore key/jiazhanghui.keystore  -storepass jiazhanghui -keypass jiazhanghui -signedjar output/new.apk -digestalg SHA1 -sigalg MD5withRSA output/new.apk 'jiazhanghui'
echo "优化安装包"
#${1} 输入业务方插件apk名字
tools/zipalign -v 4 output/new.apk output/${1}.apk
rm output/new.apk
rm -rf middle/*
rm -rf apk/*
echo "构建成功"
echo "打包完成"
