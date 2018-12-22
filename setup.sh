#!/usr/bin/env bash


function welcome(){
	echo "** CGX Linux Environment **"
        if [ -z $CGX_RESEARCH_ENABLE ] ; then
                echo "error: \$CGX_RESEARCH_ENABLE is not set"
                exit 1
        fi
	base64 "$CGX_RESEARCH_HOME/misc/logo$(( ( RANDOM %  $(ls $CGX_RESEARCH_HOME/misc/ | grep logo | wc -l)  ) ))" --decode

}

function download_survivors_i8086(){
	echo "[*] Donwloading CGX survirors..."
	git clone https://github.com/codeguru-il/corewars8086-survivors.git
}

function download_cgx_i8086_debugger(){
	echo "[*] Donwloading CGX debugger..."
	wget --no-cookies \
	--no-check-certificate \
	https://github.com/YoavKa/corewars8086/releases/download/$CGX_RESEARCH_CGX_DEBUGGER_VERSION/debugger.jar \
	-O cgx_debugger_$CGX_RESEARCH_CGX_DEBUGGER_VERSION.jar --append-output $1
	mv cgx_debugger_$CGX_RESEARCH_CGX_DEBUGGER_VERSION.jar cgx_engine_$CGX_RESEARCH_CGX_VERSION/lib/
}

function download_cgx_i8086(){
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

function download_nasm(){
	echo "[*] Installing nasm..."
	rm -r nasm_dir
	mkdir nasm_dir
	cd nasm_dir
	wget https://www.nasm.us/pub/nasm/releasebuilds/$CGX_RESEARCH_NASM_VERSION/nasm-$CGX_RESEARCH_NASM_VERSION.zip -O nasm-$CGX_RESEARCH_NASM_VERSION.zip --append-output $1
	unzip -qq nasm-$CGX_RESEARCH_NASM_VERSION.zip 
	sed -i 's/\r//' configure
	./configure
	make
	mv nasm ../environment
	mv ndisasm ../environment
	cd ../
	rm -r nasm_dir

}

function download_ant(){
	echo "[*] Downloading ant..."
	apt-get install ant
}

function download_depend_riscv_toolchain(){
	echo "[*] Downloading dependancies for risc-v toolchain"
	sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev
}

function download_riscv_toolchain(){
	echo "[*] Downloading risc-v toolchain..."
	git clone https://github.com/riscv/riscv-gnu-toolchain
	cd riscv-gnu-toolchain
	git submodule update --init --recursive
}

function build_riscv_toolchain(){
	echo "[*] Build risc-v toolchain..."
	./configure --prefix=/opt/riscv
	make linux
}

function download_cgx_riscv(){
	echo "[*] Downloading risc-v cgx"
	git clone https://github.com/erikik8090/corewars-risc-v
	cd corewars-risc-v
	git checkout --track origin/feature/rv32c
	cd -
}

function start_cgx_riscv(){
	echo "[*] Start risc-v cgx..."
	cd corewars-risc-v
	ant bootstrap
	ant devmode
	cd -
}

function download_build_i8086(){
	echo "[*] Donwloading setup for cgx i8086..."
	download_jdk $1
	download_cgx_i8086 $1
	download_cgx_i8086_debugger $1
	download_i8086_survivors
	set_symbolic_link
	download_nasm $1
}

function download_build_riscv(){
	echo "[*] Donwloading setup for cgx risc-v..."
	download_ant $1
	download_depend_riscv_toolchain $1
	download_riscv_toolchain $1
	build_riscv_toolchain $1
}


function main(){	
	welcome
	log_file=".setup_log_$(date +%Y-%m-%d_%H:%M)"
	download_build_i8086 $log_file
	download_build_riscv $log_file
	start_cgx_riscv
}

main
echo "[*] Done!"
