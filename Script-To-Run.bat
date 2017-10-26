:begin
echo off
echo -----------------------------
echo ~~Script by Tomer Eyzenberg~~
echo -----------------------------
set corewars=%cd%
chdir /d %corewars%\nasm
echo ~~%cd%~~
dir /OD /b *.asm
echo -----------------------------
echo ~~Choose survivor~~
SET /p survivor=Enter survivor ( with extension .asm ):
echo -----------------------------
echo ~~Assembling %survivor%~~
nasm.exe %survivor%
echo -----------------------------
SET survivor_ready=%survivor:~0,-4%
echo ~~Disassembling %survivor_ready%~~ 
start "code" /B /D %cd% "ndisasm.exe" %survivor_ready%  
timeout /t 1 >nul  
echo -----------------------------
echo ~~Copy %survivor_ready%~~
chdir /d %corewars%  
xcopy /s /y "%cd%\nasm\%survivor_ready%" "%cd%\survivors" 
echo -----------------------------
echo ~~Run corewars8086~~
java -cp lib\debugger.jar;lib\* il.co.codeguru.corewars8086.CoreWarsEngine
pause 
goto begin

