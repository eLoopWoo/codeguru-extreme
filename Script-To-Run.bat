:begin
echo off
echo -----------------------------
echo ~~Script by Tomer Eyzenberg~~
echo -----------------------------
set home_folder=%cd%
set nasm_folder=%cd%\nasm
set survivors_folder=%cd%\survivors
set work_folder=%cd%\work_directory
echo ~~%work_folder%~~
dir /OD /b %work_folder%\*.asm
echo -----------------------------
echo ~~Choose survivor~~
chdir /d %work_folder%
SET /p survivor_asm=Enter survivor ( with extension .asm ):
echo -----------------------------
echo ~~Copy %survivor_asm%~~
xcopy /s /y "%work_folder%\%survivor_asm%" "%nasm_folder%" 
echo ~~Assembling %survivor_asm%~~
chdir /d %nasm_folder%
nasm.exe %survivor_asm%
echo -----------------------------
SET survivor_com=%survivor_asm:~0,-4%
echo ~~Disassembling %survivor_com%~~ 
start "code" /B /D %nasm_folder% "ndisasm.exe" %survivor_com%  
timeout /t 1 >nul  
echo -----------------------------
echo ~~Copy %survivor_com%~~
move /y "%nasm_folder%\%survivor_com%" "%survivors_folder%" 
echo -----------------------------
echo ~~Run corewars8086~~
chdir /d %home_folder%  
java -cp lib\debugger.jar;lib\* il.co.codeguru.corewars8086.CoreWarsEngine
pause 
goto begin

