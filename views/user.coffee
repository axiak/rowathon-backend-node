bcrypt = require('bcrypt')
models = require('../models/models.coffee')

class UserView

  constructor: () ->

  login: (req, res) ->
    if (!req.param('password'))
      res.send(403)
      return
    user = models.User.find(email: req.param('email'),
      (result) ->
        if (result)
          bcrypt.compare(req.param('password'), result[0].password, (err, result) ->
            if (result)
              req.session.user = result[0]
              res.send(200)
            else
              res.send(403)
          )
        else
          res.send(403)
      )

  getUser: (req, res) ->
    user = models.User.find(email: req.param('email'),
      (result) ->
        res.json(if (result)
          result[0].password = undefined
          result[0]._dataHash = undefined
          result[0]
        else
          null)
    )

  changePassword: (req, res) ->
    sessionUser = req.session.user
    console.log(sessionUser)
    res.json "heh"

  register: (req, res) ->
    res.json "heh"

  logout: (req, res) ->
    res.json "boo"


module.exports = new UserView

