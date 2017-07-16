require "./materialize.config.scss"
login = require("../src/login-modal.coffee")(require("../src/materialize.coffee"))
login.login = (name, pw, cb) ->
  setTimeout (->
    cb(name==pw)
    ), 1000
createView = require "ceri-dev-server/lib/createView"
module.exports = createView

  structure: template 1, """
    <button style=margin-top:20px class="btn" @click=openLogin>Open Login</button>
    <br/>
    <p>Demo login is matching name and pw e.g. test:test</p>
  """

  methods:
    openLogin: ->
      login.open()
  tests: loginModal: ->
      it "should work", =>
        should.exist @
