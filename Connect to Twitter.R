# https://dev.twitter.com/ 

require(twitteR)

reqURL <- "https://api.twitter.com/oauth/request_token"

accessURL <- "https://api.twitter.com/oauth/access_token"

authURL <- "https://api.twitter.com/oauth/authorize"

source("HideTwitterKeys.R")

twitCred <- OAuthFactory$new(consumerKey=consumerKey,consumerSecret=consumerSecret,requestURL=reqURL,accessURL=accessURL,authURL=authURL)

if (!file.exists("cacert.pem")) {
  download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")
}

#twitCred$handshake(cainfo="cacert.pem")
twitCred$handshake(cainfo= system.file("CurlSSL", "cacert.pem", package = "RCurl"))


#Save the credentials and register
save(twitCred, file="twitter authentication.RData")
load("twitter authentication.RData")

registerTwitterOAuth(twitCred)

Kejriwal.list <- searchTwitter('#Kejriwal', n=1000, cainfo="cacert.pem")