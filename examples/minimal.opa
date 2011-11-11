// Minimal example of client/server communication
// See client.opa for more explicit code
// To compile: opa minimal.opa -o minimal.exe

import stdlib.themes.bootstrap

append_message() =
  msg = <p>{Random.string(8)}</p>
  Dom.transform([#messages +<- msg])

start() =
  <div class="container" onready={_ -> Scheduler.timer(1000, append_message)}>
    <div class="content"><h1>Messages from the server</h1><div id=#messages/></div>
  </div>

server = Server.one_page_server("Minimal client/server example", start)
