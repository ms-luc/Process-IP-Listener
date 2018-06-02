::for /f "tokens=5 delims= " %F in ('netstat -ano ^| findstr "212.73.235." ^| findstr /r "[0-9]$"') do for /f "tokens=1,2,3,4,5,6 delims= " %a in ('tasklist /v ^| findstr %F^ ') do @echo %a: %b
::for /f "tokens=5 delims=	 " %F in ('netstat -ano ^| findstr "212.73.235." ^| findstr /r "[0-9]$"') do tasklist /v | findstr %F
::for /f "tokens=2 delims=	 " %F in ('netstat -ano ^| findstr "212.73.235." ^| findstr /r "[0-9]$"') do @echo %~F
:: ^ for loop which is used to take the "fifth token aka fifth row aka token = 5"
:: netstat -ano | findstr "212.73.235." | findstr /r "[0-9]$" is used to get the lines mentioning 212.73.235. aka IP address which is replaced by @1 (the parameter)
:: ^| findstr "212.73.235." ^ uses "^" to tell batch that "212.73.235." doesn't signal end of string
:: do @echo is a continuation of the for loop
:: this segment retrieves the IP ID from a process on given IP in @1
:: the first do uses the output of 'tasklist /v ^| findstr %%F^ ' then formats to only use the first 2 columns

:: hard to explain this command ^


::ex: 212.73.235.

@echo off

if "%~1" == "" (

	goto :help
	
)

if "%~1" == "/help" (

	goto :help
	
)

if "%~1" == "/?" (

	goto :help
	
)

if "%~1" == "/a" (

	goto :advanced_header
	
)

if "%~1" == "-a" (

	goto :advanced_header
	
)


:basic
	
	echo Image Name: PID
	echo ---------------
	echo.

	for /f "tokens=5 delims= " %%F in ('netstat -ano ^| findstr "%1" ^| findstr /r "[0-9]$"') do (

		for /f "tokens=1,2,3,4,5,6 delims= " %%a in ('tasklist /v ^| findstr %%F^ ') do @echo %%a: %%b

	)

	goto :eof

:advanced_header

:: this for loop prints the first column of tasklist /v for the advanced search
	for /f "tokens=1 delims=" %%a in ('tasklist /v') do (

		@echo %%a
		
		goto :advanced
		
	)

:advanced

	echo ------------------------------------------------------------------------------------------------------
	echo.

	for /f "tokens=5 delims= " %%F in ('netstat -ano ^| findstr "%2" ^| findstr /r "[0-9]$"') do (

		tasklist /v | findstr %%F

	)

	goto :eof

:help

	echo.
	echo Usage: app_pi ip
	echo Advanced: app_pi -a ip OR app_pi /a ip
	echo.



::netstat -ano > %TEMP%\app_ip_temp.txt

::tasklist /v > %TEMP%\app_pid_temp.txt