_ = require('underscore')

bcrypt = require("../lib/myhash.coffee")
models = require("../models/models.coffee")
HASH_STRENGTH = 10

requireLogin = (viewFunction) ->
  (req, res) ->
    if req.session.user?
      viewFunction(req, res)
    else
      res.send(403)

class UserView

  constructor: () ->

  login: (req, res) =>
    if not req.param("password")?
      res.send(403)
      return
    req.session.user = undefined
    user = models.User.find email: req.param("email"), (result) =>
      if result
        bcrypt.compare req.param("password"), result[0].password, (err, matches) =>
          if matches
            req.session.user = result[0]
            UserView._sendUser(res, result[0])
          else
            res.send(403)
      else
        res.send(403)

  getUser: requireLogin (req, res) =>
    user = models.User.find email: req.param("email"), (result) =>
      if result
        UserView._sendUser(res, result[0])
      else
        res.json(null)


  changePassword: requireLogin (req, res) =>
    oldPassword = req.param("oldPassword")
    newPassword = req.param("newPassword")

    if not (oldPassword? and newPassword?)
      res.send(401)
      return

    sessionUser = req.session.user

    bcrypt.compare oldPassword, sessionUser.password, (err, matches) =>
      if matches
        bcrypt.gen_salt HASH_STRENGTH, (err, salt) ->
          return res.send(500) if err?
          bcrypt.encrypt newPassword, salt, (err, hash) ->
            return res.send(500) if err?
            models.User.find id: sessionUser.id, (result) ->
              if result
                result[0].password = hash
                result[0].save()
                res.send(200)
              else
                return res.send(500)
      else
        res.send(401)


  register: (req, res) ->
    email = req.param("email")
    password = req.param("password")

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

  logout: requireLogin (req, res) =>
    delete req.session.user
    res.send(200)

  @_sendUser: (res, user) =>
    if user?
      user = _.clone(user)
      delete user.password
      delete user._dataHash
      res.json(user)
    else
      res.json(null)

  @requireLogin = requireLogin

module.exports = new UserView

