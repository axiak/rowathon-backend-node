app = require("./app.coffee")
UserView = require('./views/user.coffee')


app.post "/user/:email/login/", UserView.login
app.post "/user/:email/register/", UserView.register

app.put "/user/:email/change-password/", UserView.requireLogin, UserView.changePassword
app.get "/user/:email/logout/", UserView.requireLogin, UserView.logout
app.get "/user/:email/", UserView.requireLogin, UserView.getUser

app.post '/save', (req, res) ->
  res.send req.xhr

