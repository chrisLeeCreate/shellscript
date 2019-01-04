#项目路径
projectPath=$PWD
echo $PWD
cp /Users/xesapp/.jenkins/android-enviroment/local.properties $projectPath

#如果有新增打包渠道 加入
if [ "${flavors_channels}" != "" ]
then
   var=${flavors_channels//,/ }    #这里是将var中的,替换为空格
   for element in $var
   do
       echo $element
       echo $element >> $projectPath/flavors.gradle
   done
fi


#删除缓存
cd app
rm -rf build
cd ..


#是否使用服务器的eox-online 在线 plugin
echo ${xol_online_buildCode}
if [ "${xol_online_buildCode}" != "" ]
then
    jarPath="/Users/xesapp/work/XesApp/Android/Apk/plugins/online/Release/${xol_online_buildCode}/"
    replacePath="$projectPath/app/src/main/assets/plugins"
	  cp -rf ${jarPath} ${replacePath}
    echo ${jarPath} ${replacePath}
else
	  echo "xol_online_buildCode is not set!"
    exit 1
fi

#是否使用服务器的家长课堂插件，如果有版本号 则用制定版本的插件
echo ${parent_class_buildCode}
if [ "${parent_class_buildCode}" != "" ]
then
    jarPath="/Users/xesapp/work/XesApp/Android/Apk/plugins/parentclass/Release/${parent_class_buildCode}/"
    replacePath="$projectPath/app/src/main/assets/plugins"
	  cp -rf ${jarPath} ${replacePath}
    echo ${jarPath} ${replacePath}
else
	  echo "parent_class_buildCode is not set!"
    exit 1
fi

#对版本号对强检验
if [ "${app_version}" != "" ]
then
  #sed -i "" 's/^APP_VERSION.*$/APP_VERSION='"${app_version}"'/g' gradle.properties
  app_version_local=$(grep "APP_VERSION" gradle.properties)
  app_version_code=`echo $app_version_local | cut -d \= -f 2`
  if [ "${app_version}" != "${app_version_code}" ]
  then
     echo "input appVersion not equals local appVersion!"
  	 exit 1
  else
  	 sed -i "" 's/^APP_VERSION.*$/APP_VERSION='"${app_version}"'/g' gradle.properties
  fi
else
  echo "app_version is not set!"
  exit 1
fi

if [ "${py_im_version}" != "" ]
then
  py_im_version_local=$(grep "PY_IM_VERSION" gradle.properties)
  py_im_version_code=`echo $py_im_version_local | cut -d \= -f 2`
  if [ "${py_im_version}" != "${py_im_version_code}" ]
  then
     echo "input py_im_version not equals local py_im_version!"
  	 exit 1
  else
  	 sed -i "" 's/^PY_IM_VERSION.*$/PY_IM_VERSION='"${py_im_version}"'/g' gradle.properties
  fi
else
  echo "py_im_version is not set!"
  exit 1
fi
