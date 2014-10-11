
if '%1'=='x86' goto X86
if '%1'=='x64' goto X64


echo "build.bat x86|x64"

goto QUIT


REM ------------------------------------------
:X86
echo x86
C:\Qt\QtIFW-1.5-32\bin\binarycreator.exe -c config\config.xml -p packages HelloSetup.exe

goto QUIT


REM ------------------------------------------
:X64
echo x64
C:\Qt\QtIFW-1.5-64\bin\binarycreator.exe -c config\config.xml -p packages HelloSetup.exe

goto QUIT


REM ------------------------------------------

:QUIT

