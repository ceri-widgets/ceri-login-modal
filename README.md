# ceri-login-modal

A simple, themed login-modal

### [Demo](https://ceri-widgets.github.io/ceri-login-modal)


# Install

```sh
npm install --save-dev ceri-login-modal
```
## Usage

```coffee
LoginModal = require("ceri-login-modal")
# load the theme (see below)
loginModal = LoginModal(
  require("ceri-login-modal/materialize"), #theme
  { # optional localization
    header: "Login"
    name: "Username"
    pw: "Password"
    button: "login"
    error: "Login failed"
    timeout: "Login failed"
  }
  )
# setup your login validation
loginModal.login = (name, pw, cb) ->
  # check login
  # call cb with the result/false for success/failed

loginModal.timeout = 2000 # change the timeout
# To open
loginModal.open((result) ->
  # result will be result from login function above
  # or false if modal got closed without proper login
)
```

#### Using Promises
```coffee
# Provide your Promise constructor
LoginModal.Promise = Promise # if you have polyfilled Promise
# your login function must return a promise
loginModal.login = (name, pw) ->
  return new Promise((resolve,reject) ->
    # check login
    # if success
    resolve(result)
    # if failed
    reject()
  )
# open will return a promise
loginModal.open().then((result)->
  # login success
  # result equals result from login function
).catch(->
  # abort by user
)
```

## Themes
#### Materialize
- setup [ceri-materialize](https://github.com/ceri-comps/ceri-materialize) and load the scss.
```scss
// make sure to import these:
@import "~materialize-css/sass/components/buttons";
@import "~materialize-css/sass/components/grid";
@import "~materialize-css/sass/components/preloader";
@import "~ceri-materialize/forms";
@import "~materialize-css/sass/components/forms/input-fields";
@import "~ceri-modal/materialize";

// and this additional requirement
@import "~ceri-login-modal/materialize";
```
- setup webpack for [ceri-icon](https://github.com/ceri-comps/ceri-icon). Include `ma-person` and `ma-vpn_key` icons.

- load theme file
```coffee
loginModal = LoginModal(require("ceri-login-modal/materialize"))
```

For example see [`dev/materialize`](dev/materialize.coffee).

# Development
Clone repository.
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## License
Copyright (c) 2017 Paul Pflugradt
Licensed under the MIT license.
