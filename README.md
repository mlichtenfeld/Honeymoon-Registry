Honeymoon-Registry
==================

Getting married, but have all the things that you need or could possibly fit into your home? Create your own custom honeymoon registry. You can add any items that you would like. A PayPal account is required to accept payments.

This project was built for Railo on Tomcat (www.getrailo.org) and was tested with MySQL, but should work on any database that supports ORM.

To install: 
==================
(assuming that you already have a PayPal account and a server with Railo installed)

1) Copy the files to a directory on your server.

2) Create a datasource for your registry. Make sure to give it permissions to read, write, create and alter.

3) Open "application_settings.cfm"

4) Enter the name of your datasource in the "orm_datasource" parameter

5) Set you database dialect if it is something other than MySQL

6) Enter the email address for your PayPal account

7) Set your deployment type. "live" will hit PayPal's production servers. Anything else, will use the PayPal sandbox for testing. 

8) Set the "notify_url". This is a script that gets hit by PayPal to let your server know that something was purchased.

9) Set the "site_root" url. This should be where users are directed after paying

10) Set the "cancel_site". This is where users should be directed if they cancel a transaction on PayPal. The URL for your registry is fine

11) Update the username and password for the admin site, which is located at <root>/admin

12) You should be all set. Go add something and try it out.

Notes:
==================
-This app could use some fine tuning. If there is a feature that you would like to see, please let me know. One feature that I may work on soon is the ability to upload images. Currently, the images have to be hosted somewhere else.

-I will work on getting a demo up shortly.
