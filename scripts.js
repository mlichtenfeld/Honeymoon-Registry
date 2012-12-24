$(document).ready(function(){
	// make all registry show item buttons active
	$(".show_registry_item").click(show_registry);
	$( "#dialog" ).dialog({ 
		autoOpen: false,
		modal: true,
		width: 600,
		show: "fade",
		position: { my: "center", at: "center", of: window }
		
	});
	// position dialog (doesn't always position properly after initialization
	$( "#dialog" ).dialog( "option", "position", { my: "center", at: "center", of: window } );

	
});

// show registry item in a pop-up dialog
function show_registry(e)
{

	// load dialog content
	$( "#dialog" ).load("display_item.cfm?id="+$(e.currentTarget).data("id"),function () {
	
		$( "#dialog" ).dialog( "option", "position", { my: "center", at: "center", of: window } );	
	})
	// open dialog
	$( "#dialog" ).dialog( "open" );
}
