crypto = require("crypto")
_ = require("underscore")

bcrypt = null

try
  bcrypt = require('bcrypt')
catch error
  colors = require("colors")
  console.warn("WARNING".red.bold + " Could not import bcrypt, falling back to sha256.")

if bcrypt
  module.exports = bcrypt
else

  stringEquals = (a, b) ->
    return false if a.length != b.length
    result = 0
    _.each _.zip(a, b), (pair) ->
      result |= pair[0] ^ pair[1]
    return result == 0

  module.exports =
    gen_salt: (strength, callback) ->
      callback(false, "")

    encrypt: (password, salt, callback) ->
      callback(false, crypto.createHash("sha256").update(password).digest("hex"))

    compare: (password1, hashed, callback) ->
      callback(false, module.exports.encrypt(password1) == hashed)
