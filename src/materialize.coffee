module.exports =
  data: ->
    icon:
      name: "ma-person"
      pw: "ma-vpn_key"
    activeLabel: "active"
  initClass:
    modal: "materialize"
    content: "modal-content"
    header: "center-align"
    nameContainer: "input-field col s12"
    nameIcon: "prefix"
    pwContainer: "input-field col s12"
    pwIcon: "prefix"
    btnContainer: "col s6 m4 push-s3 push-m4 center-align"
    btn: "btn"
    spinner: "col s1 push-s3 push-m4"
    errorMsg: "error-msg col s12 m4  push-m4 "
  connectedCallback: ->
    if @_isFirstConnect
      fn = template 1, """
        <div class="preloader-wrapper small active">
          <div class="spinner-layer">
            <div class="circle-clipper left">
              <div class="circle"></div>
            </div>
            <div class="gap-patch">
              <div class="circle"></div>
            </div>
            <div class="circle-clipper right">
              <div class="circle"></div>
            </div>
          </div>
        </div>
      """
      @spinner.appendChild(fn.call(@)[0])