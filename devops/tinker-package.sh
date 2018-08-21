#!/bin/bash
#version 20180608 
basepath="/home/tinker/code"

t_commond="git fetch --all && git reset --hard origin/"
f_branch=
f_version=
f_source_code_path="/home/tinker/code/cmt-static"
f_dst_path="/home/tinker/docker/file-server/cmt-static"
## backend param define 
b_branch=
b_version=
b_source_code_path="/home/tinker/code/cmt"
b_dst_path="/home/tinker/docker/cmt-server/gosuncn-casecenter.jar"
version_dst_path="/home/tinker/package/version"


# update front end code and delete .project .idea files ,move and replace $f_dst_path at the end 
# check frontend source code exist?skip:create&clone git resources;
f_check_source_code_exist(){
    echo "f_check_source_code_exist "
    if [ ! -d "$f_source_code_path"/.git ] ; then
        echo "creat path $f_source_code_path"
        if [ -d "$f_source_code_path" ] ; then
        	rm -rf "$f_source_code_path" ;
        fi
        mkdir -p $basepath && cd $basepath 
        git clone https://gitee.com/gosuncn/cmt-static.git
    fi
}
# check backend source code exist?skip:create&clone git resources;
b_check_source_code_exist(){
    echo "b_check_source_code_exist"
    if [ ! -d "$b_source_code_path"/.git ] ; then
        echo "creat path $b_source_code_path"
        mkdir -p $basepath && cd $basepath;
        git clone http://139.199.73.46:10080/gosuncn/cmt.git
    fi 
}

exc_update(){
    if [ $f_version ] ; then 
        echo " update to ~~ version  : $f_version "  > "$version_dst_path"/frontend/verisonInfo.txt
        cd $f_source_code_path;
        git checkout $f_version ;
	    echo " checkouting ,plz waitting"
        date  -R  >>"$version_dst_path"/frontend/verisonInfo.txt
        cp -rf $f_source_code_path  "$version_dst_path"/frontend && cd "$version_dst_path"/frontend &&  zip -v -q cmt-static.zip -x "*.git/*" -x "*.project" -r  cmt-static ;
    elif  [ $f_branch ] ; then 
        cd $f_source_code_path;
        echo " checkouting $f_branch  ,plz waitting"
        git fetch --all &&git reset --hard origin/"$f_branch";
        git log;
        cp -rf $f_source_code_path  "$version_dst_path"/frontend && cd "$version_dst_path"/frontend &&  zip -v -q cmt-static.zip -x "*.git/*" -x "*.project" -r  cmt-static ;
    else
        echo "plz  input -h to get help or -demo to get a demo commond"
    fi
    # to update backend and restart docker container
    if [ $b_version ] ; then
        echo " update to ~~ version  : $b_version "  > "$version_dst_path"/backend/verisonInfo.txt
        date -R >> "$version_dst_path"/backend/verisonInfo.txt
        cd $b_source_code_path;
        git checkout $b_version >> "$version_dst_path"/backend/verisonInfo.txt;
        cd "$b_source_code_path"/gosuncn && mvn clean package -Dmaven.test.skip=true && mv -f "$b_source_code_path"/gosuncn/**/target/*.jar  "$version_dst_path"/backend
    elif  [ $b_branch ] ; then 
    	cd $b_source_code_path;
        echo " update to ~~ version  : $f_version "   > "$version_dst_path"/backend/verisonInfo.txt
        date -R >> "$version_dst_path"/backend/verisonInfo.txt
	
        git fetch --all && git reset --hard origin/"$b_branch";
        echo "git fetch --all && git reset --hard origin/$b_branch"
        echo "doing package.... plz wait a monent "
        cd "$b_source_code_path"/gosuncn && mvn clean package -Dmaven.test.skip=true && mv -f "$b_source_code_path"/gosuncn/**/target/*.jar  "$version_dst_path"/backend
    else
        echo "plz  input -h to get help or -demo to get a demo commond"
    fi
}
creat_version_path(){
    if [ ! -d "$version_dst_path" ] ; then 
        mkdir -p "$version_dst_path"/backend;
        mkdir -p "$version_dst_path"/frontend;
    fi
}


while getopts ":b:f:B:v:t:h:d:" optname 
  do
    case "$optname" in
        "f")
            echo "git pull origin $OPTARG " 
            f_branch=$OPTARG
            ;;
        "b")
            echo "bbbbbb  $OPTARG" 
            b_branch=$OPTARG
           ;;
        "B")
            echo "BBBBBB  $OPTARG" 
            ;;
        "v")
            echo "front verison  $OPTARG"
            f_version=$OPTARG
            ;;
        "t")
            echo "back verison  $OPTARG"
            b_version=$OPTARG
            ;;
        "d")
            echo "./package -v aaa7b3e649b56d35bda56a3524ba38b79595800e -t fbc261d5d2c10b489c2da775c4eb5bee27516d79 "  
            ;;
        "h")
            echo "welcome using tinker shells ,here is tinker talking"
            echo "-f : frontend --> means it will be update cmt-static code . As far ,using -f demand a -v or branch name like -f master  or -v fbc261d5d2c10b489c2da775c4eb5bee27516d79  "
            echo "-v: git version code "
            echo "-b : backend  --> the same as -f "
            echo "-t : backend version "
            echo "-d d I'll give you a shot that how to package both backend and front;"
            echo "hello world" 
            ;;   
      "?")
            echo "Unknown option $OPTARG"
        ;;
      ":")
            echo "No argument value for option $OPTARG"
        ;;
      *)
      # Should not occur
        echo "Unknown error while processing options"
        ;;
    esac
  done
shift $(($OPTIND - 1))
f_check_source_code_exist
b_check_source_code_exist
creat_version_path
exc_update
