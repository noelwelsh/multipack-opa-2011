// Minimal channel example
// To compile: opa channel.opa -o channel.exe

import stdlib.themes.bootstrap

append_message(state, msg: string) =
  do Dom.transform([#messages +<- <p>{msg}</p>])
  {unchanged}

start() =
  channel: Session.channel(string) = Session.make({}, append_message)
  send() = Session.send(channel, Random.string(8))
  <div class="container" onready={_ -> Scheduler.timer(1000, send)}>
    <div class="content"><h1>Messages from the server</h1><div id=#messages/></div>
  </div>

server = Server.one_page_server("Channel client/server example", start)
