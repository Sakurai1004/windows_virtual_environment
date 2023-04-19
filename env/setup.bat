@echo

set curdir=%~dp0
chdir %curdir%

rem set HTTP_PROXY=http://proxy.mei.co.jp:8080
rem set HTTPS_PROXY=http://proxy.mei.co.jp:8080

set NAME=py311env
set PYTHON_VER=3.11
set PIP_VER=22.3.1

if not exist %NAME%\ (
   call :create_venv
   call :error_check
   call :check_venv
   call :error_check
   call :pip_upgrade
   call :error_check
   call :pip_install
   call :error_check
) else (
  echo %NAME% is exist
)

:create_venv
 echo create virtual environment
 py -%PYTHON_VER% -m venv %NAME%
 exit /b %ERRORLEVEL%

:check_venv
 echo check virtual environment
 %NAME%\Scripts\python --version | find /i "%PYTHON_VER%"
 exit /b %ERRORLEVEL%

:pip_upgrade
 echo pip upgrade
 %NAME%\Scripts\python -m pip install pip==%PIP_VER%
 %NAME%\Scripts\pip --version | find /i "%PIP_VER%"
 exit /b %ERRORLEVEL%

:pip_install
 echo pip install
 %NAME%\Scripts\pip install -r requirements.txt
 exit /b %ERRORLEVEL%

:error_check
if %ERRORLEVEL% neq 0 (
   rmdir /s /q %NAME%
   echo;
   echo fail to create virtual environment!
   cmd /k
   exit
)
exit /b 0
 
