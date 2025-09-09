@echo off
title Add New Changelog

::getting day, month, and year from date
set month=%date:~4,2%
set day=%date:~7,2%
set year=%date:~10,4%
:: creating filename
set file_name=TESTChangelog-%day%%month%%year%.txt

:: If the file already exists, we ask for permission to Overwrite
if not EXIST %file_name% goto DNE
echo %file_name% already exists, do you want to overwrite it?
set /p confirm="(Y/N): "
if /I %confirm%==Y goto DNE
exit
:DNE

:: creating file
echo. > %file_name%
:: getting changelog number (reduce by 1 to ignore this (batch) file)
set /a changelog_total=0
for %%a in (*) do set /a changelog_total+=1
set /a changelog_total-=1
::Tab Text preset
set "tab=   "
::converting day and month to decimal, can't have leading zeros
if %day:~0,1%==0 set day=%day:~1,1%
if %month:~0,1%==0 set month=%month:~1,1%
set /A day=%day%
set /A month=%month%
::getting text for date
set daytext=%day%th
if %day%==1 set daytext=1st

::create month array(technically a string)
set "months=January|February|March|April|May|June|July|August|September|October|November|December"
::Uses for /f to parse through the string
::grabs the word equal to the month number in the string, and uses delims to seperate the string into an array
::'in ("%months%")' means we use the 'months' string for parsing and set our month_text to the retrieved string
for /f "tokens=%month% delims=|" %%M in ("%months%") do set "month_text=%%M"

::Writing Changelog text into file
echo Changelog: #00%changelog_total% - %month_text% %daytext%, %year% >> %file_name%
echo. >> %file_name%
echo //Changes >> %file_name%
echo. %tab% >> %file_name%
echo. >> %file_name%
echo //To Do >> %file_name%
echo. %tab% >> %file_name%
echo. >> %file_name%
::pause