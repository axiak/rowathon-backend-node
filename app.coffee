express = require("express")
app = module.exports = express.createServer()
io = require('socket.io').listen app, transports: ['xhr-polling']
models = require('./models/models.coffee')


app.configure ->
  app.use express.logger()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.session(secret: 'yaeteenieCet1ahnge0reequ4ooMaeChot5aoh6gaingaiPheeyoong')
  app.use app.router

app.configure "production", ->
  app.use express.errorHandler(dumpExceptions: true, showStack: true)

io.sockets.on 'connection', (socket) ->
  socket.emit('news', hello: 'world')
  console.log('connected')
