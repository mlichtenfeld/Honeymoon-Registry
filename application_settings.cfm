<cfscript>
// datasource and dialect must be set for application to work
orm_datasource="honeymoon";
orm_dialect="MySQL"; //mysql,MicrosoftSQLServer, etc

// paypal settings
request.paypal_account_email="YOUR PAYPAL ACCOUNT EMAIL ADDRESS GOES HERE";
request.paypal_live_or_development = "dev"; // if "live", then payments will go to paypal account. anything else will use the paypal sandbox
request.paypal_notify_url="http://<url and directory of this app>"; //this is used for paypal to notify application of items purchased. i.e. http://www.myhoneymoon.com or http://www.mysite.com/myhoneymoon
request.paypal_site_root="http://<your site>"; //this controls where paypal directs user trying to return to your site
request.paypal_cancel_site="http://<url to registry>"; // this controls where paypal directs user if they cancel a transaction

//login information for registry management
request.username="admin";
request.password="password123";
</cfscript>
