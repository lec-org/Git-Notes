@echo off

cd ..

REM 获取当前的日期时间，格式为YYYY-MM-DD_HH-MM-SS
for /f "tokens=1-4 delims=/- " %%a in ('echo %date%') do (
    set "YYYY=%%a"
    set "MM=%%b"
    set "DD=%%c"
)

for /f "tokens=1-3 delims=:." %%a in ('echo %time%') do (
    set "HH=%%a"
    set "MIN=%%b"
    set "SS=%%c"
)

REM 替换日期时间中的空格为下划线
set "current_datetime=%YYYY%-%MM%-%DD%_%HH%-%MIN%-%SS%"

echo 获取更新...
cd .\.obsidian\
git fetch
echo *******************************

echo 同步远程..

git reset --hard origin/master
git pull
echo *******************************


cd ..
echo 添加所有更改中...

git add .

REM 提交更改，并包含当前日期时间和用户输入的提交信息
git commit -m "update config - %current_datetime%"
echo *******************************

echo 推送到远程仓库中...
git push

pause
