
DATE=$(date "+%Y-%m-%d%H:%M:%S")
echo $DATE
li=true
if [ "$li" = true ] ; then
echo $DATE
fi 
echo $li


if [ "$li" = true ] ; then
DATE=$(date "+%Y-%m-%d-%H:%M:%S")
echo $DATE
mv /Users/lishaowei/Desktop/bug.txt /Users/lishaowei/Desktop/${DATE}-bugs.txt 
cp -rf /Users/lishaowei/Desktop/${DATE}-bugs.txt /Users/lishaowei/Desktop/cpcpcp

fi