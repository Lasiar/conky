#!/bin/bash
runDir=$(pwd)
conkyRoot=${HOME}/.conky
conkyBinary=${conkyRoot}/binary
conkyConfigs=${conkyRoot}/configs
conkyOtherConfigs=${HOME}/.config/conky
gmailConfig=${conkyOtherConfigs}/gmail


function CheckAndCreateDir() {
    if [[ ! -d ${conkyBinary} ]]; then
        mkdir ${conkyBinary}
    fi 
    
    if [[ ! -d ${conkyOtherConfigs} ]]; then
        mkdir ${conkyOtherConfigs}
    fi

    if [[ ! -d ${gmailConfig} ]]; then
        mkdir ${gmailConfig}
    fi

    if [[ ! -d ${conkyConfigs} ]]; then
        mkdir ${conkyConfigs}
    fi
}

function InstallBinary() {
    declare -a golangModule
    golangModule=("./go/src/gmail" "./go/src/network" "./go/src/weather")


    for module in ${golangModule[@]}
    do
        go build -o  ${conkyBinary}/${module##*/}  ${module}
        echo ${conkyBinary}/${module##*/}  compile
    done
}

function CopyConfigs() {
    cp -r ./configs/ ${conkyConfigs}
}

function AddGmailConfigurations() {
    echo "Please go to \"https://developers.google.com/gmail/api/quickstart/go\" click on  button \"ENABLE THE GMAIL API\""
    echo "and save download client configuration"
    echo "enter full path gmail client configuration"
    read pathGmailConf
    cp ${pathGmailConf} ${gmailConfig}/credentials.json

    ${conkyBinary}/gmail -first
}

function main() {
    CheckAndCreateDir
    CopyConfigs
    InstallBinary
    AddGmailConfigurations
}

main
