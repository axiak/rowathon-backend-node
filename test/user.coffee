assert = require('assert')
app = require('../app.coffee')
_ = require('underscore')

routes = require('../routes.coffee')

numTests = 3

module.exports =

  setupAll: (done) ->
    assert.response(app, {
      url: "/user/miketest@axiak.net/register/"
      method: "POST"
      data: "password=abctest"
      headers:
        'content-type': 'application/x-www-form-urlencoded'
    }, {
      status: 200
    }, (res) ->
      done()
    )

  teardownAll: (done) ->
    numTests -= 1
    if not numTests
      models = require('../models/models.coffee')
      models.User.find email: "miketest@axiak.net", (results) ->
        if results
            user.remove(() ->) for user in results
    done(() ->)


  'userregistration': (done) ->
    module.exports.setupAll(() ->
      assert.response(app, {
        url: "/user/miketest@axiak.net/login/",
        method: "PUT",
        data: "password=abctest",
        headers:
          'content-type': 'application/x-www-form-urlencoded'
      }, {
        status: 200
      }, () ->
        module.exports.teardownAll(done)
      )
    )


  'userbadlogin': (done) ->
    module.exports.setupAll(() ->
      assert.response(app, {
        url: "/user/miketest@axiak.net/login/"
        method: "PUT"
        data: "password=incorrect"
        headers:
          'content-type': 'application/x-www-form-urlencoded'
      }, {
        status: 403
      }, () ->
        module.exports.teardownAll(done)
      )
    )

