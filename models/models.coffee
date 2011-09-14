orm = require('orm')

module.exports =
  User: null
  Company: null


orm.connect("mysql://rowathon:aTeihi8@mike@axiak.net/rowathon", (success, db) ->

  console.log(success)
  console.log("Error with db") if not success
  if not success
    colors = require("colors")
    console.error("ERROR ".red.bold + "Failure to connect to the db.")
    throw new Error("Failure to connect to db") 

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
