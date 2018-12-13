echo off
setlocal ENABLEDELAYEDEXPANSION
echo -----------------------------
echo ~~Script by Tomer Eyzenberg, modified by Alexey Shapovalov~~
echo -----------------------------
echo ~~script-to-run-~~
echo -----------------------------

SET /p home_path=Enter cgx root path ( if you don't know what to do just type ./):

if %home_path%==./ (
	set home_folder=%cd%
	) else ( set home_folder=%home_path%)
echo {cgx_root_path} = %home_folder%
chdir %home_folder%

:help
echo -----------------------------
echo ~~Help~~
echo This script assumes work_directory is used to store survivors .asm files.
echo It provides a way to automate the proccess: assemble->copy->run
echo It processes a .asm files stored in {cgx_root_path}/work_directory
echo -----------------------------

:begin
set nasm_folder=%cd%\nasm
set survivors_folder=%cd%\survivors
set work_folder=%cd%\work_directory

echo ~~Searching for .asm files in '%work_folder%'~~

chdir /d %work_folder%

for /r %%g in (*.asm) do (
	SET temp=%%g
	SET temp=!temp:%cd%=!
	echo !temp:~1!
)

echo -----------------------------

echo ~~Choose survivor~~
SET /p survivor=Enter survivor name (without '.asm' or numerical extention):
SET survivor=%survivor:/=\%

for /f "delims=\" %%a in ("%survivor%") do (
	set survivor_file=%%a
)

echo -----------------------------

choice /C YN /M "Compile 2 survivors?"
SET isSingle=%ERRORLEVEL%
if %isSingle% EQU 2 goto singleAssembly

echo ~~Copy %survivor%1.asm and %survivor%2.asm~~
xcopy /s /y "%work_folder%\%survivor%1.asm" "%nasm_folder%"
xcopy /s /y "%work_folder%\%survivor%2.asm" "%nasm_folder%"

echo ~~Assembling %survivor%1.asm and %survivor%2.asm~~
chdir /d %nasm_folder%
nasm.exe %survivor_file%1.asm
nasm.exe %survivor_file%2.asm
del %survivor_file%1.asm
del %survivor_file%2.asm

goto endAssembly
:singleAssembly

echo ~~Copy %survivor%.asm~~
xcopy /s /y "%work_folder%\%survivor%.asm" "%nasm_folder%"

echo ~~Assembling %survivor%.asm~~
chdir /d %nasm_folder%
nasm.exe %survivor_file%.asm
del %survivor_file%.asm

:endAssembly
echo -----------------------------

if %isSingle% EQU 2 goto singleDisassembly

echo ~~Disassembling %survivor%1~~ 
start "code" /B /D %nasm_folder% "ndisasm.exe" %survivor_file%1  
timeout /t 1 >nul  
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~Disassembling %survivor%2~~ 
start "code" /B /D %nasm_folder% "ndisasm.exe" %survivor_file%2
timeout /t 1 >nul  

goto endDisassembly
:singleDisassembly

echo ~~Disassembling %survivor%~~ 
start "code" /B /D %nasm_folder% "ndisasm.exe" %survivor_file%  
timeout /t 1 >nul  

:endDisassembly
echo -----------------------------

if %isSingle% EQU 2 goto singleCopy

echo ~~Move %survivor%1 and %survivor%2~~
move /y "%nasm_folder%\%survivor_file%1" "%survivors_folder%"
move /y "%nasm_folder%\%survivor_file%2" "%survivors_folder%"
goto endCopy
:singleCopy
echo ~~Move %survivor%~~
move /y "%nasm_folder%\%survivor_file%" "%survivors_folder%" 
:endCopy

echo -----------------------------
chdir /d %home_folder%  

choice /C YN /M "Run arena?"
if ERRORLEVEL 2 goto begin

echo ~~Run corewars8086~~
java -cp lib\debugger.jar;lib\* il.co.codeguru.corewars8086.CoreWarsEngine

pause 
goto begin

