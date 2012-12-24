<cfsilent>
	<cfscript>
		param name="session.loggedin" default="false" type="boolean";
		if (!session.loggedin)
		{
			url.event = "login";
			url.id = 0;
		}
		// url.event controls display of list, login page or item add/edit form
		param name="url.event" default="";
		// id of item if editing
		param name="url.id" default="0" type="numeric";
		// basic security. if false, then set event to login. login info available in application settings
		
		switch (url.event)
		{
			case "login":
				if (form.keyexists("username") && form.keyexists("password"))
				{
					if (form.username == request.username && form.password == request.password)
					{
						session.loggedin = true;
						location url="index.cfm" addtoken="false";
					}	
					else
						msg = "Invalid Login";	
				}
				break;
			case "logout":
				StructClear(session);
				location url="index.cfm" addtoken="false";
			case "add": // add registry item
				reg_item = EntityNew("registry");
				break;
			case "edit": // edit existing registry item
				reg_item = EntityLoadByPK("registry",url.id);
				break;
			default: // get entire registry
				 registry = EntityLoad("registry");
				 break;
		}
	</cfscript>

</cfsilent>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../bootstrap.min.css"/>
	</head>
	<body style="padding-top: 60px">
		<div class="navbar navbar-fixed-top">
		  <div class="navbar-inner">
		    <a class="brand" href="index.cfm">Honeymoon Registry</a>
			<ul class="nav">
				<li><a href="index.cfm?event=logout">Logout</a></li>
			</ul>
		  </div>
		</div>	
		
		<div class="container">
			<cfswitch expression="#url.event#">
				<cfcase value="login">
						<cfif isDefined("msg")>
							<p class="text-warning"><cfoutput>#msg#</cfoutput></p>
						</cfif>
				      <form action="index.cfm" class="form-signin" method="post">
				        <h2 class="form-signin-heading">Please sign in</h2>
				        <input type="text" class="input-block-level" name="username" placeholder="Username">
				        <input type="password" class="input-block-level" name="password" placeholder="Password">
				        <button class="btn btn-large btn-primary" type="submit">Sign in</button>
				      </form>
				</cfcase>
				<cfcase value="add,edit" delimiters=",">
					<cfoutput>
					<form action="save_item.cfm" method="post" class="form-horizontal">
					<input type="hidden" name="id" value="#iif(isnumeric(reg_item.getid()),reg_item.getid(),0)#">
					<div class="control-group">
						<label class="control-label" for="item">Item</label>
						<div class="controls">
							<input type="text" name="item" value="#reg_item.getitem()#" placeholder="Enter name of item" maxlength="50">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="requested">Requested</label>
						<div class="controls">
							<input type="text" name="requested" value="#reg_item.getrequested()#" placeholder="How many would you like?">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="bought">Bought</label>
						<div class="controls">
							<input type="text" name="bought" value="#reg_item.getbought()#" placeholder="How many do you already have?">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="price">Price per Item</label>
						<div class="controls">
							<input type="text" name="price" value="#decimalformat(reg_item.getprice())#" placeholder="How much does each item cost?"/>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="image_location">URL of Image</label>
						<div class="controls">
							<input type="text" name="image_location" value="#reg_item.getimage_location()#" placeholder="Enter the URL of an image showing the item">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="description">Description</label>
						<div class="controls">
							<textarea name="description" cols="50" rows=10 placeholder="What should guests know about the item?">#htmleditformat(reg_item.getdescription())#</textarea>
						</div>
					</div>
					<div class="control-group">
						<div class="controls">
							<input type="submit" class="btn btn-primary" value="Save">
							<input type="reset" class="btn" value="Cancel" onclick="location='index.cfm';return false;">
						</div>
					</div>

					</form>
					</cfoutput>
				
				</cfcase>
				<cfdefaultcase>
					<a href="?event=add" class="btn btn-primary">Add Item</a>
					<table class="table table-striped">
						<tr>
							<th>Item</th>
							<th>Requested</th>
							<th>Bought</th>
							<th>Price</th>
							<th>Image</th>
							<th>Description</th>
						</tr>
						<cfoutput>
							<cfloop array="#registry#" item="reg_item">
								<tr>
									<td><a href="index.cfm?event=edit&id=#reg_item.getid()#">#reg_item.getitem()#</td>
									<td>#reg_item.getrequested()#</td>
									<td>#reg_item.getbought()#</td>
									<td>#decimalformat(reg_item.getprice())#</td>
									<td><img src="#reg_item.getimage_location()#" height="50"></td>
									<td>#htmlcodeformat(reg_item.getdescription())#</td>
								</tr>
							</cfloop>
						</cfoutput>
					</table>
					<cfif NOT ArrayLen(registry)>
						There are no items in your registry
					</cfif>
				
				</cfdefaultcase>
			</cfswitch>
		</div>	
	</body>
</html>

<cfabort>
<table>
	<cfoutput><cfloop array="#registry#" item="reg_item">
		<form action="save_item.cfm" method="post">
		<input type="hidden" name="id" value="#reg_item.getid()#">
		<tr>
			<td>item<br /><input type="text" name="item" value="#reg_item.getitem()#" placeholder="item name"></td>
			<td>requested<br /><input type="text" name="requested" value="#reg_item.getrequested()#" placeholder="requested"></td>
			<td>bought<br /><input type="text" name="bought" value="#reg_item.getbought()#" placeholder="bought"></td>
			<td>price<br /><input type="text" name="price" value="#decimalformat(reg_item.getprice())#" placeholder="price"></td>
			<td>image location<br /><input type="text" name="image_location" value="#reg_item.getimage_location()#" placeholder="image location"></td>
		</tr>
		<tr>
			<td colspan="5"><textarea name="description" cols="40" rows=10>#htmleditformat(reg_item.getdescription())#</textarea></td>
		</tr>
		<tr>
			<td colspan="5"><input type="submit" value="Save"><br /><hr></td>
		</tr>
		</form>
	</cfloop></cfoutput>
		<form action="save_item.cfm" method="post">
		<input type="hidden" name="id" value="0">
		<tr>
			<td><input type="text" name="item" value="" placeholder="item name"></td>
			<td><input type="text" name="requested" value="" placeholder="requested"></td>
			<td><input type="text" name="bought" value="" placeholder="bought"></td>
			<td><input type="text" name="price" value="" placeholder="price"></td>
			<td><input type="text" name="image_location" value="" placeholder="image location"></td>
		</tr>
		<tr>
			<td colspan="5"><textarea name="description" cols="40" rows=10 pLACEHOLDER="Description"></textarea></td>
		</tr>
		<tr>
			<td colspan="5"><input type="submit" value="Save"><br /><hr></td>
		</tr>
		</form>

</table>