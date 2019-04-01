package util

import (
	"log"
	"os/user"
)

// Get home directory current user
func GetHomeDir() string {
	usr, err := user.Current()
	if err != nil {
		log.Fatalf("cant find user dir %v", err)
	}
	return usr.HomeDir
}
