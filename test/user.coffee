assert = require('assert')
app = require('../app.coffee')
routes = require('../routes.coffee')

module.exports =

  'user registration': (done) ->
    assert.response(app, {
      url: "/user/miketest@axiak.net/register/"
      method: "POST"
      data: "password=abctest"
      headers:
        'content-type': 'application/x-www-form-urlencoded'
    }, {
      status: 200
    })

    assert.response(app, {
      url: "/user/miketest@axiak.net/login/"
      method: "PUT"
      data: "password=abctest"
      headers:
        'content-type': 'application/x-www-form-urlencoded'
    }, {
      status: 200
    })
    done(() ->)


  'user bad login': (done) ->
    assert.response(app, {
      url: "/user/miketest@axiak.net/login/"
      method: "PUT"
      data: "password=incorrect"
      headers:
        'content-type': 'application/x-www-form-urlencoded'
    }, {
      status: 403
    })
    done(() ->)

