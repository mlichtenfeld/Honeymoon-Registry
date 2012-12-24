<cfscript>
	if (form.id)
		item = entityloadbypk("registry",form.id);
	else
		item = entitynew("registry");
		
	transaction
	{
		item.setitem(form.item);
		item.setbought(form.bought);
		item.setrequested(form.requested);
		item.setprice(replace(form.price,",","","all"));
		item.setdescription(form.description);
		item.setimage_location(form.image_location);
		entitysave(item);
	}
	
	location url="index.cfm" addtoken="false";
</cfscript>