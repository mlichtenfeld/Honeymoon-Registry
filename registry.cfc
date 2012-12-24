component output="false" persistent="true" table="registry" {
	property name="id" fieldtype="id" column="registry_pk" generator="native" setter="false";
	property name="item" length="50";
	property name="bought" ormtype="integer"; 
	property name="requested" ormtype="integer"; 
	property name="price" ormtype="float"; 
	property name="description" ormtype="text"; 
	property name="image_location" length="200"; 



	void function init()
	{
		variables.needed = 0;
		variables.have = 0;
		variables.price = 0;		
	}



}