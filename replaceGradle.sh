filePath=/Users/lishaowei/Desktop/shell指令集/xesApp_Android/zhikang/build.gradle
#会打包很多次，如果有com.tal.xes.app.compatplugin插件，删除
sed -i "" '/com.tal.xes.app.compatplugin/d' ${filePath}
#删除dependencies 所有依赖
sed -i "" '/dependencies/,/}/d' ${filePath}
#将dependencies文件中依赖写入build.gradle
cat /Users/lishaowei/Desktop/shell指令集/dependencies >> ${filePath}
#删除空格
sed -i "" '/^$/d' ${filePath}
