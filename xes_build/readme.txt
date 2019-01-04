Android打包工具(解压apk，删除指定列表so文件)
文件夹目录
build-
	  _
	 |
	 |-key 存放文件签名
	 |-apk 原始apk存放目录
	 |-middle 构建中间生成物存放
	 |-output 生成apk存放目录
	 |_
安装包放到 apk目录下面
打包前把middle中文件夹的内容删除，把相应的apk文件放到apk目录下，编辑channel文件，填写需要打包的渠道名称
执行 build.sh开始构建，构建结果在output下面
