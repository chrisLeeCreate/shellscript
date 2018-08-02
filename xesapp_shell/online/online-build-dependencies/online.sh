rootPath=/Users/lishaowei/StudioProjects/XOLXesAppAndroid/XOLXesApp
#rootPath=/Users/xesapp/.jenkins/workspace/android-xos-online/XOLXesApp
projectGradlePath=$rootPath/build.gradle
#删除依赖 防止重复
sed -i '' '/com.tal.xes.app:compatplugin/d' $projectGradlePath
#修改工程目录下build.gradle 依赖
sed -i '' '/dependencies {/a\
classpath "com.tal.xes.app:compatplugin:0.0.1"
' $projectGradlePath

onlineGradlePath=$rootPath/xes-online/build.gradle
echo "这个文件夹是$onlineGradlePath"
#会打包很多次，如果有com.tal.xes.app.compatplugin插件，删除
sed -i '' '/com.tal.xes.app.compatplugin/d' $onlineGradlePath
sed -i '' '/providedAarCompat/d' $onlineGradlePath


#从文件中找到project依赖项
arr=(
)
i=0

while read line 
do
if [[ $line  =~ project ]];then
echo $line
arr[i++]="$line"
fi

done <$onlineGradlePath
            

#删除dependencies 所有依赖
sed -i "" '/dependencies/,/} /d' $onlineGradlePath
#将dependencies文件中依赖写入build.gradle
cat dependencies >> $onlineGradlePath

            
#将业务方依赖的project 再次插入
for ((i=0;i<${#arr[@]};i++));
do
sed -i '' '/dependencies {/a\ 
'"${arr[i]}"'
' $onlineGradlePath
done
#删除空格
sed -i "" '/^$/d' $onlineGradlePath