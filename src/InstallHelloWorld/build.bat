
if '%1'=='x86' goto X86
if '%1'=='x64' goto X64


echo "build.bat x86|x64"

goto QUIT


REM ------------------------------------------
:X86
echo x86
c:\QtProjects\installer-framework\bin32\binarycreator.exe  -c config\config.xml -p packages HelloSetup.exe

goto QUIT


REM ------------------------------------------
:X64
echo x64
c:\QtProjects\installer-framework\bin64\binarycreator.exe -c config\config.xml -p packages HelloSetup.exe

goto QUIT


REM ------------------------------------------

:QUIT

