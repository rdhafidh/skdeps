@echo off
cd ..
title Generating VS2008...
%~dp0\premake4.exe --file=..\premake4.lua --to=.\VisualC\VS2008 vs2008
title Generating VS2010...
%~dp0\premake4.exe --file=..\premake4.lua --to=.\VisualC\VS2010 vs2010
title Generating VS2012...
%~dp0\premake4.exe --file=..\premake4.lua --to=.\VisualC\VS2012 vs2012
pause