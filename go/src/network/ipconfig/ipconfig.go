package ipconfig

import (
	"encoding/json"
	"net/http"
)

const url = "https://ifconfig.co/json"

type Info struct {
	IP         string  `json:"ip"`
	City       string  `json:"city"`
	Hostname   string  `json:"hostname"`
	Country    string  `json:"country"`
	CountryEu  bool    `json:"country_eu"`
	CountryIso string  `json:"country_iso"`
	Latitude   float64 `json:"latitude"`
	Longitude  float64 `json:"longitude"`
}

func Get() (Info, error) {
	info := new(Info)

	resp, err := http.Get(url)
	if err != nil {
		return Info{}, err
	}

	if err := json.NewDecoder(resp.Body).Decode(&info); err != nil {
		return Info{}, err
	}

	return *info, nil
}
