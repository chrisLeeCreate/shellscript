#!/bin/shell
# 函数的使用
hahaha(){
    echo lishaowei
}

echo "----函数start----"
hahaha
echo "----函数end----"

funWithReturn(){
    echo "input first number"
    read aNum
    echo "input second number"
    read tNum
   
    return $((${aNum}+${tNum}))
}
funWithReturn
#函数返回值在调用该函数后通过 $? 来获得。
echo  "output plus num $?"
