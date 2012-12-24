<cfmail from="marc@3rdFlight.com" to="marc@3rdflight.com" subject="paypal notify" type="html">
Purchase completed:<br />
Item: #form.item_name#<br />
From: #form.payer_email#<br />
Quantity: #form.quantity#
<cfdump var="#url#">
<cfdump var="#form#">
<cfdump var="#cgi#">
</cfmail>

<cfsilent>
<cfscript>
	ormreload();
	item = EntityLoadByPK("registry",form.custom);
	transaction
	{
		num_bought = item.getbought();
		num_bought += form.quantity;
		item.setbought(num_bought);
		EntitySave(item);	
	}
	
	
</cfscript>
</cfsilent>