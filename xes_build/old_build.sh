#!/bin/sh
name="开始构建"
filename="app.apk"
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
for line in $(<channel)
do
	echo "开始构架渠道   $line"
	rm /Users/wally/Library/apktool/framework/1.apk
	rm output/"$line"/new.apk
	rm output/"$line"/"$line".apk
	rm output/"$line"/
	sed -ig "s/android:value=\"$channelkey\"/android:value=\"$line\"/g"  middle/AndroidManifest.xml
	java -jar tools/apktool.jar b  middle -o output/"$line"/new.apk
	echo "签名安装包"
	jarsigner -verbose -keystore key/jiazhanghui.keystore  -storepass jiazhanghui -keypass jiazhanghui -signedjar output/"$line"/new.apk -digestalg SHA1 -sigalg MD5withRSA output/"$line"/new.apk 'jiazhanghui'
	echo "优化安装包"
	tools/zipalign -v 4 output/"$line"/new.apk output/"$line"/"$line".apk
	rm output/"$line"/new.apk
	echo "构建成功   $line"
	channelkey=$line
done
echo "打包完成"
