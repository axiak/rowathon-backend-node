app = require('./app.coffee')
routes = require('./routes.coffee')

app.listen process.env.C9_PORT ? 3000

io = app.socketIo = require('socket.io').listen app, transports: ['xhr-polling']

io.sockets.on 'connection', (socket) ->
  socket.emit('news', hello: 'world')
  console.log('connected')

console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
