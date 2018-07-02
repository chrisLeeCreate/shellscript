path=/Users/lishaowei/StudioProjects/XOLXesAppAndroid/XOLXesApp
#删除依赖 防止重复
sed -i '' '/com.tal.xes.app:compatplugin/d' $path/build.gradle
#修改工程目录下build.gradle 依赖
sed -i '' '/dependencies {/a\
classpath "com.tal.xes.app:compatplugin:0.0.1"
' $path/build.gradle
#遍历所有模块
for file in $path/*
do
    #判断是目录还是文件
    if [  -d $file ]
    then
       #区分app模块，app模块需要用ProvidedAAR
       if test $file = $path/app
       then
            echo "这个文件夹是app"
            #会打包很多次，如果有com.tal.xes.app.compatplugin插件，删除
            sed -i '' '/com.tal.xes.app.compatplugin/d' $file/build.gradle
            sed -i '' '/providedAarCompat/d' $file/build.gradle


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

            done <$file/build.gradle
            

            #删除dependencies 所有依赖
            sed -i "" '/dependencies/,/} /d' $file/build.gradle
            #将dependencies文件中依赖写入build.gradle
            cat dependencies >> $file/build.gradle

            
            #将业务方依赖的project 再次插入
            for ((i=0;i<${#arr[@]};i++));
            do
                sed -i '' '/dependencies {/a\ 
                '"${arr[i]}"'
                ' $file/build.gradle
            done
            #删除空格
            sed -i "" '/^$/d' $file/build.gradle
       else
            #其他模块implement api,implementation换成 compileOnly
            echo $file

            while read line 
            do
                if [[ $line =~ commonresource ]]
                then
                echo $line
                else
                tempCompile=`pwd`/temp.text
                touch $tempCompile
                echo "$line" > $tempCompile
                sed -i '' "s/api/compileOnly/" $tempCompile
                sed -i '' "s/implementation/compileOnly/" $tempCompile
                insertCompile=`cat $tempCompile`
                sed -i '' "s/$line/$insertCompile/" $file/build.gradle
                fi
            done <$file/build.gradle
       fi
    fi
done 







