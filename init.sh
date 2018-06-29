#!/bin/bash
read -p "please input the source repo name : " sourceRepo
read -p "please input your userName : " userName
read -p "please input the hook port : " hookPort
thisPwd=`pwd`
repo="${thisPwd}/repo"
sed -i "s/^sourceRepo=.*$/sourceRepo=${sourceRepo}/" ./deploy.sh
sed -i "s/^userName=.*$/userName=${userName}/" ./deploy.sh
sed -i "s/^const hookPort=.*$/hookPort=${hookPort}/" ./deploy.js
npm i exec &
if [[ -d ${repo} ]]; then
    rm -rf ${repo}
fi
mkdir -p ${repo}/${sourceRepo} ${userName}.github.io/${sourceRepo}
cd ${repo}/${sourceRepo}
git init
git remote add origin git@github.com:${userName}/${sourceRepo}.git
cd ${repo}/${userName}.github.io
git init
git remote add origin git@github.com:${userName}/${userName}.git
cd ${thisPwd}
sh deploy.sh
exit 0