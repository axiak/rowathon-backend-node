orm = require('orm')

module.exports =
  User: null
  Company: null


orm.connect("mysql://rowathon:aTeihi8@localhost/rowathon", (success, db) ->
  console.log("Error with db") if not success
  throw new Error("Failure to connect to db") if not success

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
