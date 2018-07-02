#!/bin/bash
#

# sed -i '' '/dependencies {/a\
#         classpath "com.tal.xes.app:compatplugin:0.0.1"
# ' lishaowei

arr=(
)
i=0
file=`pwd`/lishaowei
while read line 
do
        if [[ $line  =~ project ]];then
                echo $line
                arr[i++]="$line"
        fi
done <$file
for ((i=0;i<${#arr[@]};i++));
do
        sed -i '' '/dependencies {/a\ 
        '"${arr[i]}"'
        ' $file
done


#/*
#*/
# pro=`grep "project" lishaowei`
# echo "$pro"
# for h in $pro
# do
#     echo $h
# done
# sed -i "" '/dependencies {/a\ 
# '"${pro}"'
# ' $file


    