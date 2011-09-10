express = require("express")
app = module.exports = express.createServer()
io = require('socket.io').listen app
models = require('./models/models.coffee')
UserView = require('./views/user.coffee')

app.configure ->
  app.use express.logger()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.session(secret: 'yaeteenieCet1ahnge0reequ4ooMaeChot5aoh6gaingaiPheeyoong')
  app.use app.router

app.configure "production", ->
  app.use express.errorHandler(dumpExceptions: true, showStack: true)

app.get "/user/:email/login/", UserView.login
app.post "/user/:email/change-password/", UserView.changePassword
app.post "/user/:email/register/", UserView.register
app.post "/user/:email/logout", UserView.logout
app.get "/user/:email/", UserView.getUser

app.post '/save', (req, res) ->
  console.log req.body
  console.log req.params
  res.send req.xhr

app.listen 3000

io.sockets.on('connection', (socket) ->
    socket.emit('news', hello: 'world')
    console.log('connected')
  )

console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env


