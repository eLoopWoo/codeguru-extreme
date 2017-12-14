#!/bin/bash
function starta {
  echo -----------------------------
  echo ~~Script by Tomer Eyzenberg~~
  echo -----------------------------
  nasm_folder="$home_folder"/nasm_mac
  survivors_folder="$home_folder"/survivors
  work_folder="$home_folder"/work_directory
  echo ~~"$work_folder"~~
  echo $(ls "$work_folder" | grep .asm)
  echo -----------------------------
  echo ~~Choose survivor~~
  cd "$work_folder"
  echo "Enter survivor (with extension .asm)":
  read survivor_asm
  echo -----------------------------
  echo ~~Copy "$survivor_asm"~~
  echo ""$work_folder"//"$survivor_asm" "$nasm_folder""
  cp "$work_folder"//"$survivor_asm" "$nasm_folder"
  echo ~~Assembling "$survivor_asm"
  cd "$nasm_folder"
  ./nasm "$survivor_asm"
  rm "$survivor_asm"
  echo -----------------------------
  len=${#survivor_asm}
  four=4
  l=`expr $len - $four`
  zero=0
  echo "$l"
  survivor_com="${survivor_asm:zero:l}"
  echo ~~Disassembling "$survivor_com"
  ./ndisasm "$survivor_com"
  echo -----------------------------
  echo ~~Copy "$survivor_com"~~
  mv "$nasm_folder/$survivor_com" "$survivors_folder"
  echo -----------------------------
  echo ~~Run corewars8086~~
  cd "$home_folder"
  sudo java -cp lib/debugger.jar:lib/* il.co.codeguru.corewars8086.CoreWarsEngine
  read -rsn1 -p"Press any key to continue";echo
}
echo off
echo -----------------------------
echo ~~Script by Tomer Eyzenberg~~
echo -----------------------------

echo "Enter cgx root path ( enter ./ for default use current path)"
read a

# Equality Comparison
if [ "$a" == "./" ]; then
  home_folder=$PWD
else
  home_folder="$a"
fi
echo "$home_folder"
cd "$home_folder"
while true; do
	starta
done
