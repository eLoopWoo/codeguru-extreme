#!/bin/bash
echo off
echo -----------------------------
echo ~~Script by Tomer Eyzenberg~~
echo -----------------------------

echo Enter cgx root path ( enter ./ for defautl use current current path):
read home_path
if ["$home_path"=="./"]; then
	home_folder="$pwd"
else 
	home_folder="$home_path")
echo "$home_folder"
cd home_folder

while true; do
	start
	done

function start{
	echo -----------------------------
	echo ~~Script by Tomer Eyzenberg~~
	echo -----------------------------

	nasm_folder="$home_folder"\nasm
	set survivors_folder="$home_folder"\survivors
	set work_folder="$home_folder"\work_directory
	echo ~~"$work_folder"~~
	echo $(ls | grep .asm)
	echo -----------------------------
	echo ~~Choose survivor~~
	cd "$work_folder"
	echo Enter survivor ( with extension .asm ):
	read survivor_asm
	echo -----------------------------
	echo ~~Copy "$survivor_asm"~~
	cp "$work_folder"\\"$survivor_asm" "$nasm_folder" 
	echo ~~Assembling "$survivor_asm"~~
	cd "$nasm_folder"
	./nasm.exe "$survivor_asm"
	rm "$survivor_asm"
	echo -----------------------------
	survivor_com="${$survivor_asm:0:-4}"
	echo ~~Disassembling "$survivor_com"~~ 
	"$nasm_folder/ndisasm.exe" "$survivor_com"  
	timeout /t 1 >nul  
	echo -----------------------------
	echo ~~Copy "$survivor_com"~~
	move /y "%nasm_folder%\%survivor_com%" "%survivors_folder%" 
	echo -----------------------------
	echo ~~Run corewars8086~~
	cd "$home_folder"
	sudo java -cp lib/debugger.jar;lib/* il.co.codeguru.corewars8086.CoreWarsEngine
	read -rsn1 -p"Press any key to continue";echo
}

