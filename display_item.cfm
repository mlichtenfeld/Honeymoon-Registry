<cfscript>
	// page expects numeric id of item to be displayed
	param name="url.id" type="numeric";
	// load registry item
	item = EntityLoadByPK("registry",url.id);
</cfscript>
<html>
<body style="font-size: 12px;">
	<cfif NOT request.paypal_live_or_development IS "live">
		<div class="alert">
		  <strong>Warning!</strong> Application is in testing mode. Payments will not be collected
		</div>
	</cfif>
	<div class="row">
		<div class="span3">
			<cfoutput>
				<img class="show_item" data-id="#item.getid()#" data-title="#item.getItem()#" src="#item.getimage_location()#">
			</cfoutput>
		</div>
		<div class="span4">
			<table class="table table-bordered">
				<tr>
					<th style="font-size: 12px;">Requested</th>
					<th style="font-size: 12px;">Needed</th>
					<th style="font-size: 12px;">Price</th>
				</tr>
				<cfoutput>
					<tr>
						<td style="font-size: 12px;">#item.getrequested()#</td>
						<td style="font-size: 12px;">#item.getrequested()-item.getbought()#</td>
						<td style="font-size: 12px;">#dollarformat(item.getprice())#</td>
					</tr>
					<tr>
						<td colspan="3" style="font-size: 12px;">#item.getdescription()#</td>
					</tr>
				</cfoutput>
			</table>
		</div>
	</div>
	<table>
		<tr>
			<td style="width: 50px;vertical-align:top; font-weight: bold; font-size: 10px; padding-right: 10px">PayPal</td>
			<td style="padding: 5px; font-size: 10px">
				You can use your credit card or Paypal account to purchase this gift. With this option, you get the benefit of adjusting the quantity to your liking in addition to immediately notifying us of your generosity! Clicking the button to the right will send you through the whole process.
            	<form action="<cfoutput>#request.paypal_url#</cfoutput>" method="post">
					<input type="hidden" name="cmd" value="_xclick">
					<!--REPLACE THIS unless you want me to recieve your paypal payments -->
					<input type="hidden" name="business" value="<cfoutput>#request.paypal_account_email#</cfoutput>">
					<input type="hidden" name="lc" value="US">
					<!--REPLACE THIS with the title of the item being purchased -->
					<input type="hidden" name="item_name" value="Honeymoon Fund: <cfoutput>#item.getitem()#</cfoutput>">
					<input type="hidden" name="amount" value="<cfoutput>#item.getprice()#</cfoutput>">
					<input type="hidden" name="currency_code" value="USD">
					<input type="hidden" name="button_subtype" value="services">
					<input type="hidden" name="no_note" value="1">
					<input type="hidden" name="no_shipping" value="1">
					<input type="hidden" name="undefined_quantity" value="1">
					<input type="hidden" name="rm" value="1">
					<!--REPLACE THIS with your websites -->
					<input type="hidden" name="custom" value="<cfoutput>#item.getid()#</cfoutput>">
					<input type="hidden" name="notify_url" value="<cfoutput>#request.paypal_notify_url#/paypal_notify.cfm</cfoutput>">
					<input type="hidden" name="return" value="<cfoutput>#request.paypal_site_root#</cfoutput>">
					<input type="hidden" name="cancel_return" value="<cfoutput>#request.paypal_cancel_site#</cfoutput>">
					<input type="hidden" name="bn" value="PP-BuyNowBF:btn_buynow_LG.gif:NonHosted">
					<!--- button is set to disabled if all items in category are purchased --->
					<button type="submit" <cfif item.getrequested()-item.getbought() == 0> disabled="disabled"</cfif> >&#x2764; Buy us this gift.</button> 
					<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
				</form>			
			</td>
		</tr>
		<tr>
			<td style="vertical-align:top; font-weight: bold; font-size: 10px; padding-right: 10px">Cash or Check</td>
			<td style="padding: 5px; font-size: 10px">If PayPal isn't your cup of tea, you can use cash or a check instead! Our families can also give you alternative gift ideas if you'd like to ask them.</td>
		</tr>
	</table>



</body>
</html>