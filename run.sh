package main

import (
	"fmt"

	flickr "gopkg.in/masci/flickr.v2"
)

var (
	api_key    string
	api_secret string
	method     string
	frob       string
)

func main() {
	oauth()
}

func oauth() {
	fmt.Println("Please input your API key ")
	fmt.Scanln(&api_key)
	fmt.Println("please input your API Secret ")
	fmt.Scanln(&api_secret)
	client := flickr.NewFlickrClient(api_key, api_secret)
	requestok, _ := flickr.GetRequestToken(client)
	url, err := flickr.GetAuthorizeUrl(client, requestok, "write")
	if err != nil {
		fmt.Println("Please Check Your Net Work,I can not connect to flickr")
		return
	}
	fmt.Println("")
	fmt.Println("Please Open the follow url to get your code!")
	fmt.Println("")
	fmt.Println(url)
	var code string
	fmt.Println("Please input your Code:")
	fmt.Scan(&code)
	fmt.Println("<===Done===>")
	_, errs := flickr.GetAccessToken(client, requestok, code)
	if errs != nil {
		fmt.Println("Your API_KEY or API_SECRET or Your Code is error")
		return
	}
	fmt.Println("<==Please Input these value to your SiteConfig.json==>")
	fmt.Println("oauth_token:", client.OAuthToken)
	fmt.Println("oauth_token_secret:", client.OAuthTokenSecret)
	fmt.Println("oauth_id:", client.Id)
}
