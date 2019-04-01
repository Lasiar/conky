#!/bin/bash
runDir=$(pwd)
conkyRoot=${HOME}/.conky
conkyBinary=${conkyRoot}/binary
conkyConfig=${HOME}/.config/conky
gmailConfig=${conkyConfig}/gmail

function CheckAndCreateDir() {
    if [[ ! -d ${conkyBinary} ]]; then
        mkdir ${conkyBinary}
    fi 
    
    if [[ ! -d ${conkyConfig} ]]; then
        mkdir ${conkyConfig}
    fi

    if [[ ! -d ${gmailConfig} ]]; then
        mkdir ${gmailConfig}
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
    InstallBinary
    AddGmailConfigurations
}

main
