import tweepy

consumer_key = "BMhqhcHGohPnKtrvUvgDLDNoe";
#eg: consumer_key = "YisfFjiodKtojtUvW4MSEcPm";


consumer_secret = "ORYOW7mC2PDzjc5sh3JKWOzbH2vDE97uerdAPvlsn7OhNKQwY1";
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "229680192-ojB1orUG7S0S6hXD8MpkPCIM1NoecaYh2D6jKxb9";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "8Jj1tNIOwDaVt7KNt9VrfohVjKcRpdvvuMlBdTFL0IAXS";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



