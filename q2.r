library("httr")
myapi <- oauth_app("github", key= "996ca835310ccb16b027" , secret= "1da990e6aa15335494c8c6c5f9e4663fd445b393")
ep <- oauth_endpoints("github")
req <- GET("https://api.github.com/users/jtleek/repos", config(token = oauth2.0_token(ep, myapi)))
           
           