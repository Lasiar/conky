package main

import (
	"context"
	"golang.org/x/oauth2"
	"google.golang.org/api/gmail/v1"
	"log"
	"path"
)

func GetUnreadMessage(srv *gmail.Service) ([]*gmail.Message) {
	messages, err := srv.Users.Messages.List(user).LabelIds("INBOX").Q("is:unread").Do()
	if err != nil {
		log.Fatalf("error get messages: %v", err)
	}
	return messages.Messages
}

func GetClient(configAuth *oauth2.Config) *gmail.Service {

	tokFile := path.Join(ConfigDir, "token.json")
	tok, err := tokenFromFile(tokFile)
	if err != nil {
		log.Fatalf("open token: %v", err)
	}

	srv, err := gmail.New(configAuth.Client(context.Background(), tok))
	if err != nil {
		log.Fatalf("new client gmail: %v", err)
	}
	return srv
}
