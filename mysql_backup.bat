@echo off

REM  Simple mysqldump wrapper to save full database backup
REM  in day-dirs ex. mysql_dump\2013-10-11\dump-2012-09-19_20-26-31,72.sql
REM  easy to use, easy to search and organize, easy to modify
REM  tested on MS Windows 7 Ultimate
REM  some issues may occurs in date format after 2010 year on older systems


REM 
REM  CONFIG
REM 


REM mysqldump.exe command path, use absolute path if isn't in PATH 
set mysqldump_cmd=D:\xampp\mysql\bin\mysqldump.exe
REM common repository dir, relative or absolute
set repository=mysql_dump

REM file prefix
set prefix=dump-

REM 
REM  ADVANCED SETTINGS 
REM 

REM today, current date, format: 2013-10-11 
set day="%DATE:/=-%"
REM now, current time 2013-10-11_12:45:09.72
set now="%DATE:/=-%_%TIME::=-%"
REM output filename, without extension - see below why?
set filename=%prefix%%now%
REM dir of a day...
set repository_day=%repository%\\%day%


REM create destination dirs, could be 1 line with command extensions
IF NOT EXIST %repository%  mkdir %repository%
IF NOT EXIST %repository_day%  mkdir %repository_day%

REM go
REM modify mysqldump parameters as you want
REM if you have gzip, you can filter output with pipe operator 
REM %mysqldump_cmd% -u root  --all-databases | gzip -9 >  %repository_day%\%filename%.sql.gz
%mysqldump_cmd% -u root  --all-databases >  %repository_day%\%filename%.sql
