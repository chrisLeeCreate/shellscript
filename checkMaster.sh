function checkMaster()
{
    cd $1 
    git pull origin master:master
    git pull origin $2:$2
    UnmergeCommit="./UnmergeCommit"
    git log master ^$2 >$UnmergeCommit
    commitLog=`cat $UnmergeCommit`
    echo $commitLog
    if [ ! -z "$commitLog" ];
        then
        echo "master分支的代码尚未合并至该分支"
        rm -rf $UnmergeCommit
        exit
    else
        rm -rf $UnmergeCommit
    fi
   
}

checkMaster /Users/lishaowei/StudioProjects/xesApp_Android feature/803-online
#checkMaster /Users/lishaowei/StudioProjects/xesApp_Android feature/420
