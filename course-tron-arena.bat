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
	echo 1)Add survivor-asm (.asm)
	echo 2)Del survivor
	echo 3)Run debugger
	echo 4)Run silent
	echo 5)Show /survivors
	echo 6)Show /work_directory
	set /p input-config=Enter an option: 
		if %input-config%==0 (
		goto add-survivor
		)
		if %input-config%==1 (
		goto add-survivor-asm
		)
		if %input-config%==2 (
		goto del-survivor
		)
		if %input-config%==3 (
		goto run-debugger
		) 
		if %input-config%==4 (
		goto run-silent
		) 
		if %input-config%==5 (
		goto show-survivors
		)
		if %input-config%==6 (
		goto show-work-directory
		)
		echo ~~Bad Input~~
		echo -----------------------------
		goto tron-legacy-config
		
	:add-survivor
		echo -----------------------------
		echo ~~tron-legacy-add-survivor~~
		echo -----------------------------
		set nasm_folder=%cd%\nasm
		set survivors_folder=%cd%\survivors
		set work_folder=%cd%\work_directory
		echo ~~%work_folder%~~
		dir /OD /b %work_folder%\*.
		echo -----------------------------
		echo ~~Choose survivor~~
		chdir /d %work_folder%
		SET /p survivor_com=Enter survivor:
		echo ~~Copy %survivor_com%~~
		copy /y "%work_folder%\%survivor_com%" "%survivors_folder%"
		chdir /d %home_folder%  
		goto tron-legacy-config
	:add-survivor-asm
		echo -----------------------------
		echo ~~tron-legacy-add-survivor-asm~~
		echo -----------------------------
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
		chdir /d %home_folder%  
		goto tron-legacy-config 
	:del-survivor
		echo -----------------------------
		echo ~~tron-legacy-del-survivor~~
		echo -----------------------------
		set survivors_folder=%cd%\survivors
		echo ~~%survivors_folder%~~
		dir /OD /b %survivors_folder%\*
		echo -----------------------------
		echo ~~Choose survivor~~
		chdir /d %survivors_folder%
		SET /p survivor=Enter survivor:
		SET survivor_ready=%survivor%
		echo -----------------------------
		del %survivors_folder%\%survivor%
		chdir /d %home_folder%  
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
		set survivors_folder=%cd%\survivors
		echo ~~%survivors_folder%~~
		dir /OD /b %survivors_folder%\*
		goto tron-legacy-config
	:show-work-directory
		echo -----------------------------
		echo ~~tron-legacy-show-work-directory~~
		echo -----------------------------
		set work_folder=%cd%\work_directory
		echo ~~%work_folder%~~
		dir /OD /b %work_folder%\*.asm
		dir /OD /b %work_folder%\*.
		goto tron-legacy-config
goto begin


