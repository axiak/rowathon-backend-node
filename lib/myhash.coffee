crypto = require("crypto")
_ = require("underscore")

bcrypt = null

try
  bcrypt = require('bcrypt')
catch error
  colors = require("colors")
  console.warn("warning  - ".red.bold + "Could not import bcrypt, falling back to sha256.")

if bcrypt
  module.exports = bcrypt
else

  stringEquals = (a, b) ->
    return false if a.length != b.length
    result = 0
    for i in [0..a.length]
      result |= a.charCodeAt(i) ^ b.charCodeAt(i)
    return result == 0

  module.exports =
    gen_salt: (strength, callback) ->
      callback(undefined, "")

    encrypt: (password, salt, callback) ->
      callback(undefined, crypto.createHash("sha256").update(password).digest("hex"))

    compare: (password1, hashed, callback) ->
      module.exports.encrypt password1, '', (err, realHash) ->
        callback(undefined, stringEquals(realHash, hashed))

