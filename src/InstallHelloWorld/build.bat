@echo off

REM ------------------------------------------
REM �I�����C�����I�t���C����������


if '%2'=='offline' goto OFFLINE
goto ONLINE

:OFFLINE
echo offline
set OFFLINE=--offline-only
goto ARCH

:ONLINE
echo online
set OFFLINE=
goto ARCH



REM ------------------------------------------
REM �A�[�L�e�N�`��������
:ARCH

if '%1'=='x86' goto X86
if '%1'=='x64' goto X64


echo "build.bat x86|x64 [offline]"

goto QUIT


REM ------------------------------------------
REM �A�[�L�e�N�`�����Ƃ̏���

REM ------------------------------------------
:X86
echo x86
C:\Qt\QtIFW-1.5-32\bin\binarycreator.exe %OFFLINE% -c config\config.xml -p packages HelloSetup.exe

goto QUIT


REM ------------------------------------------
:X64
echo x64
C:\Qt\QtIFW-1.5-64\bin\binarycreator.exe %OFFLINE% -c config\config.xml -p packages HelloSetup.exe

goto QUIT


REM ------------------------------------------
REM �I��
:QUIT

