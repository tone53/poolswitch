@echo off
cd %~dp0
color 0a
cls
echo =========POOL-SWITCH===========
echo ===============================
:download
echo Press 1 Switch Pool to Sumo	#1
echo Press 2 Switch Pool to Haven	#2
echo Press 3 Switch Pool to LOKI	#3
echo ...
echo Press 5  EXIT NOW 		#5
echo ...
echo ===============================
set /p apps=

if %apps%==1 goto 1
if %apps%==2 goto 2
if %apps%==3 goto 3
if %apps%==4 goto 4
if %apps%==5 goto 5


:1
echo Switch Pool to Sumo......Now.
copy pools-sumo.txt pools.txt /y
Taskkill /F /IM xmr-stak.exe
timeout /t 3 /nobreak >nul
exit
:2
echo Switch Pool to Haven......Now.
copy pools-haven.txt pools.txt /y
Taskkill /F /IM xmr-stak.exe
timeout /t 3 /nobreak >nul
exit
:3
echo Switch Pool to LOKI......Now.
copy pools-loki.txt pools.txt /y
Taskkill /F /IM xmr-stak.exe
timeout /t 3 /nobreak >nul
exit
:4
echo App 4
exit
:5
echo Press 5 Exit Now...
timeout /t 2 /nobreak >nul
exit