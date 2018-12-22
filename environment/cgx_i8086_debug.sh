#!/usr/bin/env bash


function welcome(){
	base64 "$CGX_RESEARCH_HOME/misc/logo$(( ( RANDOM %  $(ls $CGX_RESEARCH_HOME/misc/ | grep logo | wc -l)  ) ))" --decode
	echo "** CGX Linux Environment **"
        if [ -z $CGX_RESEARCH_ENABLE ] ; then
                echo "error: \$CGX_RESEARCH_ENABLE is not set"
                exit 1
        fi

}

function cgx_debug(){
	echo "[*] Debug i8086 CGX..."
	cd $CGX_RESEARCH_CGX
	$CGX_RESEARCH_JDK/bin/java -cp "lib/cgx_debugger_$CGX_RESEARCH_CGX_DEBUGGER_VERSION.jar:lib/commons-math3-3.4.1.jar" il.co.codeguru.corewars8086.CoreWarsEngine
	cd -
}
function main(){	
	welcome
	cgx_debug
}

main
echo "[*] Done!"
