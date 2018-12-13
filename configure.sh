#!/usr/bin/env bash


function welcome(){
	base64 "misc/logo$(( ( RANDOM %  $(ls misc/ | grep logo | wc -l)  ) ))" --decode
	export CGX_RESEARCH_ENABLE="1"
	if [ -z "$1" ]; then
		echo "usage: source configure project_path"
		export CGX_RESEARCH_ENABLE="0"
	fi
}

function configure(){
	export CGX_RESEARCH_ENABLE="1"
	export CGX_RESEARCH_CGX_VERSION="4.0.2"
	export CGX_RESEARCH_CGX_DEBUGGER_VERSION="v5"
	export CGX_RESEARCH_JDK_VERSION="jdk1.8.0_191"

	export CGX_RESEARCH_HOME=$(readlink -f $1)
	export CGX_RESEARCH_ENV=$CGX_RESEARCH_HOME/environment
	export CGX_RESEARCH_JDK=$CGX_RESEARCH_HOME/jdk1.8.0_191
	export CGX_RESEARCH_CGX=$CGX_RESEARCH_HOME/cgx_engine_$CGX_RESEARCH_CGX_VERSION

	# https://github.com/YoavKa/corewars8086/releases/download/v5/debugger.jar
	# https://github.com/codeguru-il/corewars8086/releases/download/corewars8086-4.0.2/corewars8086-4.0.2.zip
}

function main(){	
	welcome $1
	configure $1
}

main $1
echo "Done!"
