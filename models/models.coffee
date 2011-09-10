orm = require('orm')

module.exports = {}

orm.connect("mysql://rowathon:aTeihi8@localhost/rowathon", (success, db) ->
  throw "Failure to connect to db" if (!success)

  User = module.exports.User = db.define("users",
    email:
      type: "string"
    password:
      type: "string"
    date_joined:
      type: "date"
    activation_token:
      type: "string"
      default: ""
  )

  Company = module.exports.Company = db.define("companies",
    name:
      type: "string"
  )

  User.hasOne("company", Company)

  Company.sync()
  User.sync()


)

