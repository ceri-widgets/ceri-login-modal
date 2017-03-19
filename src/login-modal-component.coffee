
module.exports =
  mixins: [
    require "ceri/lib/structure"
    require "ceri/lib/computed"
    require "ceri/lib/class"
    require "ceri/lib/#model"

    require "ceri/lib/#if"
  ]
  structure: template 1, """
    <ceri-modal #ref=modal>
      <div #ref=content>
        <h4 #ref=header :text="text.header"></h4>
        <div class=row>
          <div #ref=nameContainer>
            <ceri-icon :name=icon.name #ref=nameIcon></ceri-icon>
            <input 
              #ref=nameInput 
              #model=name 
              @keyup=focusPW 
              @input=nameChanged
              @focus=onActiveName
              @blur=onActiveName
              />
            <label #ref=nameLabel :text="text.name"></label>
          </div>
        </div>
        <div class=row>
          <div #ref=pwContainer>
            <ceri-icon :name=icon.pw #ref=pwIcon></ceri-icon>
            <input 
              #ref=pwInput 
              #model=pw
              @keyup=loginEvent
              type="password"
              @input=pwChanged
              @focus=onActivePW
              @blur=onActivePW
              />
            <label #ref=pwLabel :text="text.pw"></label>
          </div>
        </div>
        <div class=row>
          <div #ref=btnContainer>
            <button 
              @click=loginEvent 
              #ref=btn 
              :text=text.button
              :disabled=state.disabled
              > 
            </button>
            
          </div>
          <div #ref=spinner #if=state.active></div>
          <div 
            #if=state.failed
            #ref=errorMsg 
            :text=state.failed
            >
          </div>
        </div>
      </div>
    </ceri-modal>
  """
  data: ->
    text:
      header: "Login"
      name: "Username"
      pw: "Password"
      button: "login"
      error: "Login failed"
      timeout: "Login failed"
    icon:
      name: ""
      pw: ""
    name: ""
    pw: ""
    activeLabel: ""
    timeout: 2000
    state:
      valid: true
      resolved: false
      rejected: false
      active: false
      failed: ""

  methods:
    setActiveLabel: (input,label) ->
      return unless input and label
      if input != document.activeElement and input.value == ""
        @$class.setStr label, ""
      else
        @$class.setStr label, @activeLabel
    onActiveName: ->
      @setActiveLabel @nameInput, @nameLabel
    onActivePW: ->
      @setActiveLabel @pwInput, @pwLabel
      @state?.disabled = @pw == ""
    focusPW: (e) ->
      if e.keyCode == 13
        if @pw == ""
          @pwInput.focus()
        else
          @loginEvent(e)
    loginEvent: (e) ->
      return if e.type == "keyup" and e.keyCode != 13
      @state.active = true
      @state.disabled = true
      timeout = setTimeout (=>
        @state.active = false
        @state.disabled = false
        @state.failed = @text.timeout
        return
        ), @timeout
      cleanup = =>
        clearTimeout(timeout)
        @state.active = false
        @state.disabled = false
        @pw = ""
      success = (result) =>
        cleanup()
        @cb?(result)
        @resolve?(result)
        @resolve = null
        @reject = null
        @cb = null
        @modal.hide()
        
      failed = =>
        cleanup()
        @pwInput.focus()
        @state.failed = @text.error
      cb = (result) ->
        if result
          success(result)
        else
          failed()
      promise = @login? @name, @pw, cb
      promise?.then(success).catch(failed)
    nameChanged: ->
      @pw = ""
      @state.failed = false
    pwChanged: ->
      @state.failed = false
      
    open: (cb) ->
      @cb = cb
      document.body.appendChild(@)
      @modal.show()
      @nameInput.focus()
      @onActivePW()
      if @Promise
        return new @Promise (resolve, reject) =>
          @resolve = resolve
          @reject = reject
  watch:
    name: "onActiveName"
    pw: "onActivePW"
    "modal.open": (val) ->
      if val == false
        @cb?(false)
        @cb = null
        @reject?()
        @reject = null
        @resolve = null
        @state.active = false
        @state.failed = ""