cp /Users/xesapp/.jenkins/workspace/android-enviroment/local.properties /Users/xesapp/.jenkins/workspace/android-xol-online/XOLXesApp

if ${packageJar}
then
#对在线插件依赖进行修改
sh /Users/xesapp/work/XesApp/Android/plugin_build/online_build/online.sh
fi
