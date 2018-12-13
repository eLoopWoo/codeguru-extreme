#!/usr/bin/env bash


function welcome(){
	echo "** CGX Linux Environment **"
        if [ -z $CGX_RESEARCH_ENABLE ] ; then
                echo "error: \$CGX_RESEARCH_ENABLE is not set"
                exit 1
        fi
	base64 "$CGX_RESEARCH_HOME/misc/logo$(( ( RANDOM %  $(ls $CGX_RESEARCH_HOME/misc/ | grep logo | wc -l)  ) ))" --decode

}

function download_survivors(){
	echo "[*] Donwloading CGX survirors..."
	git clone https://github.com/codeguru-il/corewars8086-survivors.git
}

function download_cgx_debugger(){
	echo "[*] Donwloading CGX debugger..."
	wget --no-cookies \
	--no-check-certificate \
	https://github.com/YoavKa/corewars8086/releases/download/$CGX_RESEARCH_CGX_DEBUGGER_VERSION/debugger.jar \
	-O cgx_debugger_$CGX_RESEARCH_CGX_DEBUGGER_VERSION.jar --append-output $1
	mv cgx_debugger_$CGX_RESEARCH_CGX_DEBUGGER_VERSION.jar cgx_engine_$CGX_RESEARCH_CGX_VERSION/lib/
}

function download_cgx(){
	echo "[*] Donwloading CGX..."
	wget --no-cookies \
	--no-check-certificate \
	https://github.com/codeguru-il/corewars8086/releases/download/corewars8086-$CGX_RESEARCH_CGX_VERSION/corewars8086-$CGX_RESEARCH_CGX_VERSION.zip \
	-O cgx_$CGX_RESEARCH_CGX_VERSION.zip --append-output $1
	unzip -qq cgx_$CGX_RESEARCH_CGX_VERSION.zip
	rm cgx_$CGX_RESEARCH_CGX_VERSION.zip
	mv corewars8086-$CGX_RESEARCH_CGX_VERSION cgx_engine_$CGX_RESEARCH_CGX_VERSION
}

function download_jdk(){
	echo "[*] Donwloading JDK..."
	wget --no-cookies \
	--no-check-certificate \
	--header "Cookie: oraclelicense=accept-securebackup-cookie" \
	http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz \
	-O jdk-8u191-linux-x64.tar.gz --append-output $1

	tar -xf jdk-8u191-linux-x64.tar.gz
	rm jdk-8u191-linux-x64.tar.gz
}

function set_symbolic_link(){
	echo "[*] Symbolic link for survivros/zombies..."
	rm -r $CGX_RESEARCH_CGX/survivors
	rm -r $CGX_RESEARCH_CGX/zombies

	ln -s $CGX_RESEARCH_ENV/survivors $CGX_RESEARCH_CGX/survivors 
	ln -s $CGX_RESEARCH_ENV/zombies $CGX_RESEARCH_CGX/zombies 

}

function download(){
	download_jdk $1
	download_cgx $1
	download_cgx_debugger $1
	download_survivors
	set_symbolic_link
}

function main(){	
	welcome
	log_file=".setup_log_$(date +%Y-%m-%d_%H:%M)"
	download $log_file
}

main
echo "[*] Done!"
