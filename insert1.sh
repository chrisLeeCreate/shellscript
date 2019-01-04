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
        sed -i '' "s/$line/$insertCompile/" dependencies
    fi
done <dependencies
rm -rf $tempCompile
