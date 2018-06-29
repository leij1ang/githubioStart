#!/bin/bash
sourceRepo={{}}
userName={{}}
thisPwd=`pwd`
cd ./repo/${sourceRepo}
git fetch --all
git reset --hard origin/master
#根据项目需求修改以下
npm i
npm run build:prod
rm -rf ${thisPwd}/repo/${userName}.github.io/${sourceRepo}/*
shopt -s expand_aliases
if [[ `alias|grep` != '' ]]; then
    unalias cp
    cp -rf dist/* ${thisPwd}/repo/${userName}.github.io/${sourceRepo}
    alias cp='cp -i'
else
    cp -rf dist/* ${thisPwd}/repo/${userName}.github.io/${sourceRepo}
fi

#根据项目需求修改以上
gitlog=`git log --oneline -1`
cd ${thisPwd}/repo/${userName}.github.io/
git add .
git commit -am "${gitlog}"
git push --force
