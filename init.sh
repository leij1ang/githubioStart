#!/bin/bash
read -p "please input the source repo name : " sourceRepo
read -p "please input your userName : " userName
read -p "please input the hook port : " hookPort
thisPwd=`pwd`
sed -i "s/^sourceRepo=.*$/sourceRepo=${sourceRepo}/" ./deploy.sh
sed -i "s/^userName=.*$/userName=${userName}/" ./deploy.sh
sed -i "s/^const hookPort=.*$/hookPort=${hookPort}/" ./deploy.js
npm i exec &
if [[ -d ${thisPwd}/repo ]]; then
    rm -rf ${thisPwd}/repo
fi
mkdir -p ${thisPwd}/repo/${sourceRepo} ${userName}.github.io/${sourceRepo}
cd ${thisPwd}/repo/${sourceRepo}
git init
git remote add origin git@github.com:${userName}/${sourceRepo}.git
cd ${thisPwd}/repo/${userName}.github.io
git init
git remote add origin git@github.com:${userName}/${userName}.git
cd ${thisPwd}
sh deploy.sh
exit 0