#!/bash/shell
#lishaowei
#复制当前文件夹中，带有特定字符的文件夹到另一个文件夹中
path=/Users/xesapp/work/XesApp/Android/Apk/*
for file in ${path}
do
 echo ${file}
if [[ ${file} =~ "6" ]]
then
   
    cp -rf ${file} /Users/xesapp/work/XesApp/Android/Apk/flavors
    rm -rf ${file}
fi
done