component output="false" {
	this.name ="honeymoon_registry"; // CHANGE THIS TO THE NAME OF YOUR APPLICATION
	
	this.applicationTimeout = createTimeSpan( 0, 1, 0, 0 );
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0,1,0,0)
	this.setClientCookies = true;
	this.setDomainCookies = true;

	include "application_settings.cfm";

	// confirm database settings are in place
	if (!orm_datasource.length() || !orm_dialect.length())
	{
		writeoutput("Please set a datasource and database dialect in 'application_settings.cfm'");
		abort;		
	}

		
	this.ormenabled = true;
	this.datasource=orm_datasource;
	this.ormSettings = {
		dbCreate = "update",
		cfcLocation = "#getdirectoryfrompath(getcurrenttemplatepath())#",
		flushAtRequestEnd = false,
		dialect = orm_dialect,
		secondaryCacheEnabled=false
	};
	
	
	boolean function onApplicationStart()
	{
		return true;
	}
	

	boolean function onRequestStart(targetPage)
	{
		if (request.paypal_live_or_development == "live")
			request.paypal_url = "https://www.paypal.com/cgi-bin/webscr";
		else
			request.paypal_url = "https://www.sandbox.paypal.com/cgi-bin/webscr";
		return true;
	}
}