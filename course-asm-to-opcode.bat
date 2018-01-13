echo off
echo -----------------------------
echo ~~Script by Tomer Eyzenberg~~
echo -----------------------------
echo -----------------------------
echo ~~Assembly to Opcode~~
echo -----------------------------
SET /p home_path=Enter cgx root path ( if you don't know what to do just type ./):
if %home_path%==./ (
	set home_folder=%cd%
	) else ( set home_folder=%home_path%)
echo {cgx_root_path} = %home_folder%
chdir %home_folder%
:begin
set nasm_folder=%cd%\nasm
chdir /d %nasm_folder%
set temp_file=%cd%\assembly_temp.asm

:help
echo -----------------------------
echo ~~Help~~
echo -----------------------------
echo This script can help you disassemble assembly instruction's
echo and view their opcode's interactively.
echo -----------------------------
echo ~~Assembly to Opcode~~
echo -----------------------------
:assembly-opcode
echo Enter assembly lines
echo Press Enter twice when finished
echo (may not contain  ^<, ^>, ^|, ^&, or un-closed quotes)
set new_line=""
break > %temp_file%
:still_typing
set /p new_line=">"
if errorlevel 1 echo. >> %temp_file% & set /p new_line=">"
if errorlevel 1 echo ----------------------------- & goto done_typing
echo %new_line% >> %temp_file%
goto still_typing

:done_typing
nasm.exe %temp_file%
SET temp_com=%temp_file:~0,-4%
start "code" /B /D %nasm_folder% "ndisasm.exe" %temp_com%
timeout /t 1 >nul
del %temp_file%
del %temp_com%
echo -----------------------------
goto assembly-opcode

