/*
Add the following to the page where you want to load the widget.

<script
  src="http://localhost:4000/assets/widget.js"
  data-path="/widget/questionnaire"
></script>
*/

import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

const currentScript = document.currentScript
const widgetHost = new URL(currentScript.src).origin;
const widgetPath = document.currentScript.getAttribute("data-path");
const url = `${widgetHost}/${widgetPath}`

fetch(url, { credentials: "include" })
  .then(response => response.text())
  .then(data => {
    const container = document.createElement("div")

    container.innerHTML = data;
    currentScript.before(container)
  
    const csrfToken = document.querySelector("meta[name='widget-csrf-token']").getAttribute("content")
    const liveSocket = new LiveSocket(`${widgetHost}/live`, Socket, {
      longPollFallbackMs: 2500,
      params: {_csrf_token: csrfToken}
    })

    liveSocket.href = url
    liveSocket.connect()
    window.liveSocket = liveSocket
  })

