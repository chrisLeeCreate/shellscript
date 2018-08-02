code=$(grep "PLUGIN_XOS_CODE" /Users/xesapp/.jenkins/workspace/android-enviroment/build.properties)
num=`echo $code | cut -d \= -f 2`
sed -i "" 's/^PLUGIN_XOS_CODE.*$/PLUGIN_XOS_CODE='"$[${num}+1]"'/g' /Users/xesapp/.jenkins/workspace/android-enviroment/build.properties



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



#新建一个plugins路径
plugin_path=/Users/xesapp/work/XesApp/Android/Apk/plugins
if [ ! -d "$plugin_path" ];then
	mkdir $plugin_path
else
	echo "文件夹已经存在"
fi


#apk保存路径为，环境名称+app版本号+code号
temp_apk=${plugin_path}/online/${num}
if [ ! -d "$temp_apk" ];then
	mkdir -p $temp_apk #-p 创建多层级目录
else
	echo "文件夹已经存在"
fi
#current保存地址
current_apk=${plugin_path}/online/current
if [ ! -d "$current_apk" ];then
	mkdir -p $current_apk #-p 创建多层级目录
else
	echo "文件夹已经存在"
fi


#判断apk还是jar
xosPath="/Users/xesapp/.jenkins/workspace/android-xol-online/XOLXesApp/xes-online/build/outputs/apk"

if ${packageJar}
then
    pth="XOLXesApp/xes-online/build/outputs/apk/${mEnv}"
    cd ${pth}
 	for file in /Users/xesapp/.jenkins/workspace/android-xol-online/${pth}/*
	do
	if [ "${file##*.}"x = "apk"x ]
	then 
       #判断apk结尾
       channelNum=$( wc -l </Users/xesapp/work/XesApp/Android/xes_build/so_list)
	   echo ${channelNum}
	   if [ ${channelNum} -gt 0 ]
	   then 
   		  echo "so白名单大于0"
          #如果so文件白名单列表大于0，则删除
          xes_build="/Users/xesapp/work/XesApp/Android/xes_build"
          cd ${xes_build}
          cp -rf ${file} ${xes_build}/apk
          #执行删除so文件脚本
          sh build.sh online
          #将apk改名为jar
          mv ${xes_build}/output/online.apk ${xes_build}/output/online.jar
          #复制jar到服务器
          cp -rf ${xes_build}/output/* ${temp_apk}
          rm -rf ${plugin_path}/online/current/*
          cp -rf ${xes_build}/output/* ${plugin_path}/online/current
          #删除so文件中的缓存
		  rm -rf /Users/xesapp/work/XesApp/Android/xes_build/output/*
	   else
       	  #so白名单列表为空，直接更改apk为jar。放入服务器
   		  echo "so白名单等于小于0"
          mv ${file} ${xosPath}/online.jar
          cp -rf ${xosPath}/online.jar ${temp_apk}
 		  rm -rf ${plugin_path}/online/current/*
		  cp -rf ${xosPath}/online.jar ${plugin_path}/online/current
	   fi
	fi
	done  
	
else
#复制打好的apk到服务器保存
 cp -rf /Users/xesapp/.jenkins/workspace/android-xol-online/XOLXesApp/xes-online/build/outputs/apk ${temp_apk}
 #rm -rf ${xosPath}/online/current/*
fi


#修改权限
chmod -R 755 /Users/xesapp/work/XesApp/Android/Apk/

#rm -rf /Users/xesapp/.jenkins/workspace/android-xol-online
#rm -rf /Users/xesapp/.jenkins/workspace/android-xol-online@tmp
