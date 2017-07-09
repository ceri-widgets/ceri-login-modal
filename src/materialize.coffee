module.exports =
  mixins: [
    require("ceri-progress/mixin")(require("ceri-progress/materialize"))
    require("ceri-toaster/mixin")(require("ceri-toaster/materialize"))
    ]
  data: ->
    icon:
      name: "ma-person"
      pw: "ma-vpn_key"
    activeLabel: "active"
  initClass:
    modal: "materialize login-modal"
    content: "modal-content"
    header: "center-align"
    nameContainer: "input-field col s12"
    nameIcon: "prefix"
    pwContainer: "input-field col s12"
    pwIcon: "prefix"
    btnContainer: "col s6 m4 push-s3 push-m4 center-align"
    btn: "btn"