# PhoenixEmbedded

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

To test the embedded page:

  * Visit https://getbootstrap.com/
  * Paste into the console the following code:
  ```
  main = document.querySelectorAll('main')[0]
  new_main = document.createElement("main")
  main.replaceWith(new_main)

  script = document.createElement("script")
  script.src = "http://localhost:4000/assets/widget.js"
  script.setAttribute("data-path", "/widget/questionnaire")
  new_main.appendChild(script)
  ```

## Presentation

https://github.com/aronwolf90/phoenix-embedded-presentation/blob/master/main.pdf
