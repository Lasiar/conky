#!/bin/bash
declare -a golangModule
golangModule=("./go/src/gmail" "./go/src/network" "./go/src/weather")

runDir=$(pwd)
conkyRoot=${HOME}/.conky
conkyBinary=${conkyRoot}/binary
#if [[ -d ${conkyRoot} ]]; then
#    rm -rf ${conkyRoot}/*
#ff
if [[ -d ${conkyBinary}/binary ]]; then
    mkdir ${conkyBinary}
fi

for module in ${golangModule[@]}
do
    go build -o  ${conkyBinary}/${module##*/}  ${module}
    echo ${module} compile
done