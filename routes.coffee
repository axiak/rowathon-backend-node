app = require("./app.coffee")
UserView = require('./views/user.coffee')

app.get "/user/:email/login/", UserView.login
app.get "/user/:email/change-password/", UserView.changePassword
app.get "/user/:email/register/", UserView.register
app.put "/user/:email/logout", UserView.logout
app.get "/user/:email/", UserView.getUser

app.post '/save', (req, res) ->
  res.send req.xhr

