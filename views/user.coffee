bcrypt = require('../lib/myhash.coffee')
models = require('../models/models.coffee')
HASH_STRENGTH = 10

class UserView

  constructor: () ->

  login: (req, res) ->
    if not req.param('password')?
      res.send(403)
      return
    user = models.User.find email: req.param('email'), (result) ->
      if result
        bcrypt.compare req.param('password'), result[0].password, (err, matches) ->
          if matches
            req.session.user = result[0]
            res.send(200)
          else
            res.send(403)
      else
        res.send(403)

  getUser: (req, res) ->
    user = models.User.find email: req.param('email'), (result) ->
      res.json(if result
        delete result[0].password
        delete result[0]._dataHash
        result[0]
      else
        null)


  changePassword: (req, res) ->
    sessionUser = req.session.user
    console.log(sessionUser)
    res.json "heh"

  register: (req, res) ->
    email = req.param('email')
    password = req.param('password')

    if not (email? and password?)
      res.send(401)
      return

    date_joined = new Date()
    bcrypt.gen_salt HASH_STRENGTH, (err, salt) ->
      throw new Error("Password error: #{err}") if err?
      bcrypt.encrypt password, salt, (err, hash) ->
        throw new Error("Password error: #{err}") if err?
        newUser = new models.User(
          email: email,
          password: hash,
          date_joined: date_joined,
          activation_token: ""
        )
        newUser.save (err, newUserSaved) ->
          throw new Error("Could not save user: #{err}") if err?
          delete newUserSaved.password
          res.json newUserSaved

  logout: (req, res) ->
    res.json "boo"

module.exports = new UserView

