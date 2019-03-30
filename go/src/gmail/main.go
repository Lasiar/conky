package main

import (
	"conky/go/src/util"
	"flag"
	"fmt"
	"golang.org/x/oauth2/google"
	"google.golang.org/api/gmail/v1"
	"io/ioutil"
	"log"
	"path"
)

const user string = "me"

var (
	first bool

	credentialsFile = path.Join(ConfigDir, "credentials.json")
	ConfigDir       = path.Join(util.GetHomeDir(), ".config/conky/gmail/")
	tokenFile       = path.Join(ConfigDir, "token.json")
)

func init() {
	flag.BoolVar(&first, "first", false, "for first start")
	flag.Parse()
}

func main() {
	credentials, err := ioutil.ReadFile(credentialsFile)
	if err != nil {
		log.Fatalf("error open credentials file: %v", err)
	}

	configAuth, err := google.ConfigFromJSON(credentials, gmail.GmailReadonlyScope)

	if first {
		CreateToken(configAuth)
		return
	}
	fmt.Println(len(GetUnreadMessage(GetClient(configAuth))))
}
