module.exports =
  module:
    rules: [{ 
        test: /ceri-icon(\/src)?\/icon/
        enforce: "post"
        loader: "ceri-icon"
        options:
          icons: [
              "ma-person"
              "ma-vpn_key"
            ]
    }]
