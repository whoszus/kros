#!/bin/bash
jar_base_path="/home/tinker/package/version/backend"
target="/home/tinker/package/cmt-server/"
if [ ! -d "$jar_base_path" ] ;then 
	exit
fi

#cp -rf $jar_base_path/gosuncn-admin.jar  $target/admin/ ;
cp -rf $jar_base_path/gosuncn-casecenter.jar  $target/casecenter/ ; 
cp -rf $jar_base_path/gosuncn-archivescenter.jar  $target/archivecenter/ ; 
cp -rf $jar_base_path/gosuncn-cloudconfig.jar  $target/cloudconfig/ ; 
cp -rf $jar_base_path/gosuncn-eureka.jar  $target/eureka/ ; 
cp -rf $jar_base_path/gosuncn-faceapi.jar  $target/faceapi/ ; 
cp -rf $jar_base_path/gosuncn-im.jar  $target/im/ ; 
cp -rf $jar_base_path/gosuncn-interrogate.jar  $target/interrogate/ ; 
cp -rf $jar_base_path/gosuncn-permissions.jar  $target/permission/ ; 
cp -rf $jar_base_path/gosuncn-thirdapi.jar  $target/thirdapi/ ; 
cp -rf $jar_base_path/gosuncn-zuul.jar  $target/zuul/ ; 
cp -rf $jar_base_path/gosuncn-config-center.jar  $target/configcenter/ ; 