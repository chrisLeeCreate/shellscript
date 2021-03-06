#sdk路径
cp /Users/xesapp/.jenkins/workspace/android-enviroment/local.properties /Users/xesapp/.jenkins/workspace/android-xesApp


#检测当前分支是否合并了master分支代码
if [ $enviroment == "Release" ]
then
	git pull origin master:master
	git pull origin $branch:$branch
	UnmergeCommit="./UnmergeCommit"
	git log master ^$branch >$UnmergeCommit
	commitLog=`cat $UnmergeCommit`
	echo $commitLog
	if [ ! -z "$commitLog" ];
	then
  		echo "master分支的代码尚未合并至该分支"
 	    rm -rf $UnmergeCommit
  		#强行停止
  		master分支的代码尚未合并至该分支 
  		exit
	else
 		rm -rf $UnmergeCommit
	fi
fi

#删掉临时build缓存
cd app
rm -rf build

cd ..

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




#是否使用服务器的zhikang plugin
echo ${useZhikangCloudPlugin}
if  ${useZhikangCloudPlugin} 
then 
	jarPath="/Users/xesapp/work/XesApp/Android/Apk/plugins/zhikang/current/"
    replacePath=" /Users/xesapp/.jenkins/workspace/android-xesApp/app/src/main/assets/plugins"
	cp -rf ${jarPath} ${replacePath}
    echo ${replacePath}
fi

#是否使用服务器的eox-online 在线 plugin
echo ${useXosOnlineCloudPlugin}
if  ${useXosOnlineCloudPlugin} 
then 
	jarPath="/Users/xesapp/work/XesApp/Android/Apk/plugins/online/current/"
     replacePath=" /Users/xesapp/.jenkins/workspace/android-xesApp/app/src/main/assets/plugins"
	cp -rf ${jarPath} ${replacePath}
    echo ${replacePath}
fi


if [ "${py_im_version}" != "" ]  
then  
  sed -i "" 's/^PY_IM_VERSION.*$/PY_IM_VERSION='"${py_im_version}"'/g' gradle.properties
else    
  echo "py_im_version is not set!"  
fi   

if [ "${app_version}" != "" ]  
then  
  sed -i "" 's/^APP_VERSION.*$/APP_VERSION='"${app_version}"'/g' gradle.properties
else    
  echo "app_version is not set!"  
fi   

if [ "${dt_im_version}" != "" ]  
then  
  sed -i "" 's/^DT_IM_VERSION.*$/DT_IM_VERSION='"${dt_im_version}"'/g' gradle.properties
else    
  echo "dt_im_version is not set!"  
fi   
