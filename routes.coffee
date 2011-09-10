app = require("./app.coffee")

UserView = require('./views/user.coffee')

app.get "/user/:email/login/", UserView.login
app.post "/user/:email/change-password/", UserView.changePassword
app.post "/user/:email/register/", UserView.register
app.post "/user/:email/logout", UserView.logout
app.get "/user/:email/", UserView.getUser

app.post '/save', (req, res) ->
  console.log req.body
  console.log req.params
  res.send req.xhr

