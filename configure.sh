#!/usr/bin/env bash


function welcome(){
	base64 "misc/logo$(( ( RANDOM %  $(ls misc/ | grep logo | wc -l)  ) ))" --decode
	export CGX_RESEARCH_ENABLE="1"
	if [ -z "$1" ]; then
		echo "****"
		echo "usage: source configure project_path"
		echo "****"
		export CGX_RESEARCH_ENABLE="0"
	fi
}

function configure(){
	export CGX_RESEARCH_ENABLE="1"
	export CGX_RESEARCH_CGX_VERSION="4.0.2"
	export CGX_RESEARCH_CGX_DEBUGGER_VERSION="v5"
	export CGX_RESEARCH_JDK_VERSION="jdk1.8.0_191"
	export CGX_RESEARCH_NASM_VERSION="2.13"

	export CGX_RESEARCH_HOME=$(readlink -f $1)
	export CGX_RESEARCH_ENV=$CGX_RESEARCH_HOME/environment
	export CGX_RESEARCH_JDK=$CGX_RESEARCH_HOME/jdk1.8.0_191
	export CGX_RESEARCH_CGX=$CGX_RESEARCH_HOME/cgx_engine_$CGX_RESEARCH_CGX_VERSION
}

function main(){	
	welcome $1
	configure $1
}

main $1
echo "Done!"
