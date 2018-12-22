#!/usr/bin/env bash


function welcome(){
	base64 "$CGX_RESEARCH_HOME/misc/logo$(( ( RANDOM %  $(ls $CGX_RESEARCH_HOME/misc/ | grep logo | wc -l)  ) ))" --decode
	echo "** CGX Linux Environment **"
        if [ -z $CGX_RESEARCH_ENABLE ] ; then
                echo "error: \$CGX_RESEARCH_ENABLE is not set"
                exit 1
        fi

	if [ -z "$1" ]; then
		echo "usage: ./cgx_riscv_build.sh file_path"
		exit 1
	fi

}

function build(){
	echo "[*] Building riscv survivor $1..."
	survivor_name=$(basename $1 .asm)
	echo $survivor_name
	/opt/riscv/bin/riscv32-unknown-linux-gnu-as $1 -o $2
	/opt/riscv/bin/riscv32-unknown-linux-gnu-objcopy -O binary $2 $survivor_name
	echo "[*] Built $survivor_name..."
}
function main(){	
	welcome $1
	tmp_file="/tmp/.cgx_tmp_elf_$(date +%Y-%m-%d_%H:%M)"
	build $1 $tmp_file
}

main $1
echo "[*] Done!"
