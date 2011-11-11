// Example of code running on the server and client
// To compile: opa client.opa -o client.exe

// This code is far more explicit than necessary. We could just embed
// the Scheduler in the HTML and it would Just Work. The presentation
// here makes it a bit clearer what is going on IMO.

import stdlib.themes.bootstrap

/* Messages sent from server to client have this type */
type message = {text: string}

/* Client and server communicate via this network */
@publish network = Network.cloud("network"): Network.network(message)

/* Runs on the client, updating the HTML */
update(m: message) =
  line = <p>{m.text}</p>
  Dom.transform([#messages +<- line ])

/* Sends a message to the client */
send_message() =
  text = Random.string(8)
  Network.broadcast({~text}, network)

/* This runs on the server, and sends the HTML to the client */
start() = 
  do Scheduler.timer(1000, send_message)
  <div class="topbar"><div class="fill"><div class="container">Opa Client/Server Example</div></div></div>
  <div class="container" onready={_ -> Network.add_callback(update, network)}>
    <div class="content"><h1>Messages from the Server</h1><div id=#messages/></div>
  </div>


server = Server.one_page_server("Client/Server example", start)
