<cfsilent>
	<cfscript>
		// load the registry data
		the_registry = EntityLoad("registry");
	</cfscript>
</cfsilent>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<!-- Copyright (c) WeddingWire Inc. 2006-2009.  All Rights Reserved. -->
<html>
	<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<!--- twitter bootstrap is used for the layout --->
	<link rel="stylesheet" type="text/css" href="bootstrap.min.css"/>
	<!--- load jquery and jquery ui for managing popup windows --->
	<link rel="stylesheet" type="text/css" href="jquery-ui-1.9.2.custom/css/smoothness/jquery-ui-1.9.2.custom.min.css"/>
	<script language="javascript" src="jquery-ui-1.9.2.custom/js/jquery-1.8.3.min.js"></script>
	<script language="javascript" src="jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.min.js"></script>
	<!--- script for managing dialogs --->
	<script language="javascript" src="scripts.js"></script>
</head>
<body>
<!--- settings check --->	
<cfif !isvalid("email",request.paypal_account_email)>
	<div class="alert">
	  <strong>Warning!</strong> Please enter a valid email address in 'application_settings.cfm' for your paypal account.
	</div>
</cfif>

<cfif !isvalid("url",request.paypal_notify_url)>
	<div class="alert">
	  <strong>Warning!</strong> Please enter a valid notification url in 'application_settings.cfm'.
	</div>
</cfif>
<cfif !isvalid("url",request.paypal_site_root)>
	<div class="alert">
	  <strong>Warning!</strong> Please enter a valid root url for your site in 'application_settings.cfm'.
	</div>
</cfif>
<cfif !isvalid("url",request.paypal_cancel_site)>
	<div class="alert">
	  <strong>Warning!</strong> Please enter a valid cancel transaction URL in 'application_settings.cfm'.
	</div>
</cfif>
	
<!--- container for pop dialog --->
<div id="dialog" title="Would you like to see us do this?"></div>

<!---
PLACE YOUR PAGE HEADER HERE
--->

<!--- BEGIN REGISTRY DISPLAY --->
<div class="container">
	<div class="row" style="margin: 10px 40px 10px 40px">
		<cfoutput>
			<cfloop array="#the_registry#" index="i" item="reg_item" >
				<div class="span3 well" style="min-height: 450px">
					<h3 style="margin-bottom: 6px;">#reg_item.getitem()#</h3>
					<img class="show_registry_item" alt="Click to View Item" style="cursor: pointer" data-id="#reg_item.getid()#" data-title="#reg_item.getItem()#" src="#reg_item.getimage_location()#" width="100%">
					<table class="table ">
						<tr>
							<th>Requested</th>
							<th>Needed</th>
							<th>Price</th>
						</tr>
						<tr>
							<td>#reg_item.getrequested()#</td>
							<td>#reg_item.getrequested()-reg_item.getbought()#</td>
							<td>#dollarformat(reg_item.getprice())#</td>
						</tr>
						<tr>
							<td colspan="3">#replacelist(reg_item.getdescription(),"#chr(13)#,#chr(10)#","<br>")#</td>
						</tr>
					</table>
					<p></p>
				</div>
				<!--- every 2 items, create a new row --->
				<cfif ! i mod 2></div><div class="row" style="margin: 10px 40px 10px 40px"></cfif>
			</cfloop>
		</cfoutput>
	</div>
</div>
<!--- END REGISTRY DISPLAY --->

<!---
PLACE YOUR PAGE FOOTER HERE
--->

</body>
</html>