@echo off
pushd "%~dp0"
c:
cd "C:\Program Files\GLPI-Agent"
for %%p in (".") do pushd "%%~fsp"
cd "C:\Program Files\GLPI-Agent\perl\bin"
start /B "" glpi-agent.exe glpi-agent %*
popd
