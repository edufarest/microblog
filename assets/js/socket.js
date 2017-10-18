// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()
	
	// Based on phoenix documentation example

	// Now that you are connected, you can join channels with a topic:
    let user = document.getElementById('info');

    var channel;

    if (user) {
        let topic = "updates:" + user.dataset.id
        console.log(topic);
        channel = socket.channel(topic, {})
        console.log("Current user: " + user.dataset.id)
    } else {
	    channel = socket.channel("updates:all", {})
    }

    let messageSubmit    = document.querySelector("#submit-button")
    let messageContent   = document.querySelector("#message-content")
	let messageContainer = document.querySelector("#messages")
	let messagePoster    = document.querySelector("#poster")
	//let liveText         = document.querySele

	if (messageSubmit && messagePoster) {
		messageSubmit.addEventListener("click", event => {
			//channel.push("new_msg", {body: messageContent.value, poster: messagePoster.value})
            
            // Get Followers
		    let followersData = document.getElementById('followers');
            console.log(followersData.dataset.followers);
            let followers = JSON.parse(followersData.dataset.followers);

            // Post in their channels

            followers.forEach(function(id) {
                let channelToPush = socket.channel("updates:" + id);
                channelToPush.join()
                channelToPush.push("new_msg", 
                        {body: messageContent.value, poster: messagePoster.value})
        
            })
        })

	}

	if (messageContainer) {
		channel.on("new_msg", payload => {
			let messageItem = document.createElement("td");
		
			let message = payload.poster + ": " + payload.body;
			messageItem.innerText = message
			messageContainer.insertBefore(messageItem, messageContainer.childNodes[0])	
		})
	}
channel.join()
	.receive("ok", resp => { console.log("Joined successfully", resp) })
	.receive("error", resp => { console.log("Unable to join", resp) })


	export default socket
