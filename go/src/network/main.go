package main

import (
	"conky/go/src/network/ipconfig"
	"fmt"
	"log"
	"strings"
)

func main() {
	info, err := ipconfig.Get()
	if err != nil {
		log.Fatal(err)
	}

	buf := new(strings.Builder)

	buf.WriteString(fmt.Sprintf("${color0}Public IP: ${color}%v\n", info.IP))

	if info.Country != "" {
		buf.WriteString(fmt.Sprintf("${color0}Country: ${color}%v\n", info.Country))
	}

	if info.City != "" {
		buf.WriteString(fmt.Sprintf("${color0}City: ${color}%v\n", info.City))
	}

	if info.Hostname != "" {
		buf.WriteString(fmt.Sprintf("${color0}City: ${color}%v\n", info.Hostname))
	}

	fmt.Println(buf.String())
}
