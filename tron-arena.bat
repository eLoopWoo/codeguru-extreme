echo off
echo -----------------------------
echo ~~Script by Tomer Eyzenberg~~
echo -----------------------------

SET /p home_path=Enter cgx root path ( ./ use current ):
if %home_path%==./ (
	set home_folder=%cd%
	) else ( set home_folder=%home_path%)
echo %home_folder%
chdir %home_folder%

echo "`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'
echo The Grid. A digital frontier. 
echo I tried to picture clusters of information as they moved through the computer. 
echo What did they look like? Ships? Motorcycles? Were the circuits like freeways? 
echo I kept dreaming of a world I thought I'd never see. And then one day . . .
echo "`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'

echo -----------------------------
echo ~~Script by Tomer Eyzenberg~~
echo -----------------------------

set temp_directory=tempo
mkdir %temp_directory% 2>NUL
::echo -----------------------------
::echo ~~Moving survivors to %cd%\%temp_directory%~~
::echo -----------------------------
::move  "%cd%\survivors\*." "%cd%\%temp_directory%" 2>NUL
:begin
echo -----------------------------
echo ~~Enter an option~~
echo -----------------------------
echo 0)Run Tron
echo 1)Run Script-To-Run once
echo 2)Run Script-To-Run loop
echo +

set /p input=Enter option:
	if %input%==0 (
	goto tron-legacy
	) 
	if %input%==1 (
	goto run-once
	) 
	if %input%==2 (
	goto run-loop
	) 
	ELSE (
	echo -----------------------------
	echo ~~Bad Input~~
	echo -----------------------------
	goto begin
	)
	

	

:run-once
	echo -----------------------------
	echo ~~run-once~~
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
	del %survivor_asm%
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
	goto begin



:run-loop
	echo -----------------------------
	echo ~~run-loop~~
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
	del %survivor_asm%
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
	goto run-loop
	
:tron-legacy
	echo -----------------------------
	echo ~~tron-legacy~~
	echo -----------------------------
	:tron-legacy-config
	echo -----------------------------
	echo ~~Enter an option~~
	echo -----------------------------
	echo 0)Add survivor
	echo 1)Del survivor
	echo 2)Run debugger
	echo 3)Run silent
	echo 4)Show /survivors
	echo 5)Show /nasm
	set /p input-config=Enter an option: 
		if %input-config%==0 (
		echo %input-config%
		goto add-survivor
		)
		if %input-config%==1 (
		goto del-survivor
		)
		if %input-config%==2 (
		goto run-debugger
		) 
		if %input-config%==3 (
		goto run-silent
		) 
		if %input-config%==4 (
		goto show-survivors
		)
		if %input-config%==5 (
		goto show-nasm
		)
		echo ~~Bad Input~~
		echo -----------------------------
		goto tron-legacy-config
		
	:add-survivor
		echo -----------------------------
		echo ~~tron-legacy-add-survivor~~
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
		del %survivor_asm%
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
		goto tron-legacy-config 
	:del-survivor
		echo -----------------------------
		echo ~~tron-legacy-del-survivor~~
		echo -----------------------------
		set corewars=%cd%
		chdir /d %corewars%\nasm
		echo ~~%cd%~~
		dir /OD /b *.asm
		echo -----------------------------
		echo ~~Choose survivor~~
		SET /p survivor=Enter survivor ( with extension .asm ):
		SET survivor_ready=%survivor:~0,-4%
		echo -----------------------------
		chdir /d %corewars%  
		move "%cd%\survivors\%survivor_ready%" "%cd%\%temp_directory%" 
		goto tron-legacy-config
	:run-debugger
		echo -----------------------------
		echo ~~tron-legacy-run-debugger~~
		echo -----------------------------
		java -cp lib\debugger.jar;lib\* il.co.codeguru.corewars8086.CoreWarsEngine
		goto tron-legacy-config
	:run-silent
		echo -----------------------------
		echo ~~tron-legacy-run-silent~~
		echo -----------------------------
		java -cp lib\debugger.jar;lib\* il.co.codeguru.corewars8086.AutoCoreWars
		goto tron-legacy-config
	:show-survivors
		echo -----------------------------
		echo ~~tron-legacy-show-survivors~~
		echo -----------------------------
		set corewars=%cd%
		chdir /d %corewars%\survivors
		echo ~~%cd%~~
		dir /OD /b
		chdir /d %corewars%  
		goto tron-legacy-config
	:show-nasm
		echo -----------------------------
		echo ~~tron-legacy-show-nasm~~
		echo -----------------------------
		set corewars=%cd%
		chdir /d %corewars%\nasm
		echo ~~%cd%~~
		dir /OD /b *.asm
		chdir /d %corewars%  
		goto tron-legacy-config
goto begin


