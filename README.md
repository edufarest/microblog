Microblog

https://github.com/edufarest/microblog
http://microblog.eduardofares.com/messages

To Login:

Click on "Users" in the navbar and "New User". Then type the email address in the textfield and click submit.
The user index will then have "show" link for all users, and an edit/delete button for the current user

After creating an account, you can type the email in the textfield in the navbar and press "Log in"

To Logout:

Click on "logout" next to the username in the navbar.

To Post:

Log in first.
Go to "Messages" and "New Message". Then type the message contents and then "Submit".

To Follow an user:

Log in first.
Go to "Users" and click "Show" for the user that you want to follow. In the show page, click on "Follow"

After following someone, their messages will appear in the "Messages" page.


To Like:

Log in first.
In the message show page, click on like. After clicking like, a small card will appear saying that you liked the post. After liking a post, the user will see the "You liked this post!" message.

To Deploy:

In the dev machine run deploy.sh. This will generate and copy a release to the server, which will then run deploy.sh in the server. This script will take care of unpacking and running the server

HW07 UPDATES:

 - Password: Users now require a +7 password to register and log in

 - Welcome Screen: If there is no user logged in, the user will be greeted with the welcome screen which will prompt them to register or log in. The user will still be able to look at messages and users, but will not be able to interact with them in any way. If there is already an user logged in, they will be redirected to their feed.

 - HTTPS: The microblog now uses HTTPS.


