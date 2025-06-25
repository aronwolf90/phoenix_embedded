import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

const currentScript = document.currentScript
const widgetHost = new URL(currentScript.src).origin;
const widgetName = document.currentScript.getAttribute("data-path");

fetch(`${widgetHost}/${widgetName}`)
  .then(response => response.text())
  .then(data => {
    const container = document.createElement("div")
    container.innerHTML = data;
    currentScript.before(container)
  })

