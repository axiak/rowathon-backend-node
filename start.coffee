app = require('./app.coffee')
routes = require('./routes.coffee')

app.listen 3000

console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
