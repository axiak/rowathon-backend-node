express = require("express")
app = module.exports = express.createServer()

app.configure ->
  app.use express.logger()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.session(secret: 'yaeteenieCet1ahnge0reequ4ooMaeChot5aoh6gaingaiPheeyoong')
  app.use app.router

app.configure "production", ->
  app.use express.errorHandler(dumpExceptions: true, showStack: true)
