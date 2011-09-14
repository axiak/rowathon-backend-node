

module.exports.createClient = (options) ->
  mysql = null
  try
    mysql = require('mysql')
  catch error
    return new MySqlClientWrapper(options)
  return mysql.createClient(options)

class MySqlClientWrapper
  constructor: (@options) ->
