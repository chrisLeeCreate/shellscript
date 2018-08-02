code=$(grep "APP_BUILD_CODE" /Users/xesapp/.jenkins/workspace/android-enviroment/build.properties)
num=`echo $code | cut -d \= -f 2`

if [ "${app_version}" = "" ]  
then
  app_code=$(grep "APP_VERSION" gradle.properties)
  app_num=`echo $app_code | cut -d \= -f 2`
  app_version=${app_num}
fi

#当前打包apk存放路径
temp_path=/Users/xesapp/work/XesApp/Android/Apk/Archive
if [ ! -d "$temp_path" ];then
	mkdir -p $temp_path
else
	echo "temp_path-文件夹已经存在"
fi

temp_apk=${temp_path}/${app_version}/${num}-${enviroment}
if [ ! -d "$temp_apk" ];then
	mkdir -p $temp_apk
else
	echo "temp_apk-文件夹已经存在"
fi



#复制apk
cp -rf app/build/outputs/apk ${temp_apk}
rm -rf /Users/xesapp/work/XesApp/Android/Apk/current
cp -rf /Users/xesapp/.jenkins/workspace/android-xesApp/app/build/outputs/apk /Users/xesapp/work/XesApp/Android/Apk/current

#如果是release 单独保存一份
if [ $enviroment == "Release" ]
then
#release apk存放路径
release_path=/Users/xesapp/work/XesApp/Android/Apk/Release-Archive
if [ ! -d "$release_path" ];then
	mkdir -p $release_path
else
	echo "release_path-文件夹已经存在"
fi

temp_release_apk=${release_path}/${app_version}/${num}-${enviroment}
if [ ! -d "$temp_release_apk" ];then
	mkdir -p $temp_release_apk
else
	echo "temp_apk-文件夹已经存在"
fi
cp -rf /Users/xesapp/.jenkins/workspace/android-xesApp/app/build/outputs/apk ${temp_release_apk}
fi


#
pth="/Users/xesapp/work/XesApp/Android/Apk/current"
for f in `ls $pth`
do
  mv "$pth/$f" "$pth/xesapp.apk"
  break
done

#环境变量转换
mEnv="debug"
if [ $enviroment == "Gamma" ]
then
   mEnv="gamma"
elif [ $enviroment == "Release" ]
then
    mEnv="release"
elif [ $enviroment == "PreRelease" ]
then
    mEnv="preRelease"
else
    mEnv="debug"
fi
echo ${mEnv}


#上传apk到蒲公英
if ${uploadToPGying}; then
	cd app
	./uploadApk.sh ${mEnv}
    num=$[${num}+1]
    cd ..
    sed -i "" 's/^APP_BUILD_CODE.*$/APP_BUILD_CODE='"${num}"'/g' /Users/xesapp/.jenkins/workspace/android-enviroment/build.properties
fi


#修改权限
chmod -R 755 /Users/xesapp/work/XesApp/Android/Apk/
#先不删除
#rm -rf /Users/xesapp/.jenkins/workspace/android-xesApp
#rm -rf /Users/xesapp/.jenkins/workspace/android-xesApp@tmp
