instance = null
module.exports = (theme, text) ->
  unless window.customElements.get("ceri-login-modal")
    unless window.customElements.get("ceri-modal")
      window.customElements.define "ceri-modal", require("ceri-modal")
    unless window.customElements.get("ceri-icon")
      window.customElements.define "ceri-icon", require("ceri-icon")
    ceri = require "ceri/lib/wrapper"
    comp = require "./login-modal-component"
    comp.mixins.push theme
    if text
      comp.mixins.push data: -> text: text
    window.customElements.define "ceri-login-modal", ceri(comp)
    instance = document.createElement "ceri-login-modal"
  return instance
