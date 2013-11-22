<cfcomponent displayname="Product" output="false">
	
	<cfscript>
		variables.instance.productUID="";
		variables.instance.productName="";
		variables.instance.productDescription="";
		variables.instance.dateCreated="";
		variables.instance.active=0;
		variables.instance.numProductPhotos=0;
		variables.instance.categoryUID="";
		variables.instance.productPhotos="";
		variables.instance.createdBy="";
	</cfscript>

	<cffunction name="init" access="public" output="false" returntype="product">
		<cfreturn this />
	</cffunction>

	<cffunction name="getProduct" access="public" output="false" returntype="Struct">
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="setProductUID" access="public" output="false">
		<cfargument name="productUID" type="string" required="true" />
		<cfset variables.instance.productUID = arguments.productUID />
	</cffunction>
	<cffunction name="getProductUID" access="public" output="false" returntype="String">
		<cfreturn variables.instance.productUID />
	</cffunction>

	<cffunction name="setProductName" access="public" output="false">
		<cfargument name="productName" type="string" required="true" />
		<cfset variables.instance.productName = arguments.productName />
	</cffunction>
	<cffunction name="getProductName" access="public" output="false" returntype="String">
		<cfreturn variables.instance.productName />
	</cffunction>

	<cffunction name="setProductDescription" access="public" output="false">
		<cfargument name="productDescription" type="string" required="true" />
		<cfset variables.instance.productDescription = arguments.productDescription />
	</cffunction>
	<cffunction name="getProductDescription" access="public" output="false" returntype="String">
		<cfreturn variables.instance.productDescription />
	</cffunction>

	<cffunction name="setDateCreated" access="public" output="false">
		<cfargument name="dateCreated" type="string" required="true" />
		<cfset variables.instance.dateCreated = arguments.dateCreated />
	</cffunction>
	<cffunction name="getDateCreated" access="public" output="false" returntype="String">
		<cfreturn variables.instance.dateCreated />
	</cffunction>

	<cffunction name="setActive" access="public" output="false">
		<cfargument name="active" type="Numeric" required="true" />
		<cfset variables.instance.active = arguments.active />
	</cffunction>
	<cffunction name="getActive" access="public" output="false" returntype="Numeric">
		<cfreturn variables.instance.active />
	</cffunction>

	<cffunction name="setNumProductPhotos" access="public" output="false">
		<cfargument name="numProductPhotos" type="Numeric" required="true" />
		<cfset variables.instance.numProductPhotos = arguments.numProductPhotos />
	</cffunction>
	<cffunction name="getNumProductPhotos" access="public" output="false" returntype="Numeric">
		<cfreturn variables.instance.numProductPhotos />
	</cffunction>

	<cffunction name="setCategoryUID" access="public" output="false">
		<cfargument name="categoryUID" type="string" required="true" />
		<cfset variables.instance.categoryUID = arguments.categoryUID />
	</cffunction>
	<cffunction name="getCategoryUID" access="public" output="false" returntype="string">
		<cfreturn variables.instance.categoryUID />
	</cffunction>

	<cffunction name="setProductPhotos" access="public" output="false">
		<cfargument name="productPhotos" type="string" required="true" />
		<cfset variables.instance.productPhotos = arguments.productPhotos />
	</cffunction>
	<cffunction name="getProductPhotos" access="public" output="false" returntype="string">
		<cfreturn variables.instance.productPhotos />
	</cffunction>

	<cffunction name="setCreatedBy" access="public" output="false">
		<cfargument name="createdBy" type="string" required="true" />
		<cfset variables.instance.createdBy = arguments.createdBy />
	</cffunction>
	<cffunction name="getCreatedBy" access="public" output="false" returntype="string">
		<cfreturn variables.instance.createdBy />
	</cffunction>

	<cffunction name="setupProduct" access="public" output="false" returntype="void">
		<cfargument name="productUID" required="false" type="string" default="" />
		<cfargument name="productName" required="false" type="string" default="" />
		<cfargument name="productDescription" required="false" type="string" default="" />
		<cfargument name="dateCreated" required="false" type="string" default="" />
		<cfargument name="active" required="false" type="numeric" default="0" />
		<cfargument name="numProductPhotos" required="false" type="numeric" default="0" />
		<cfargument name="categoryUID" required="false" type="string" default="" />
		<cfargument name="productPhotos" required="false" type="string" default="" />
		<cfargument name="createdBy" required="false" type="string" default="" />

		<cfset setProductUID(arguments.productUID) />
		<cfset setProductName(arguments.productName) />
		<cfset setProductDescription(arguments.productDescription) />
		<cfset setDateCreated(arguments.dateCreated) />
		<cfset setActive(arguments.active) />
		<cfset setNumProductPhotos(arguments.numProductPhotos) />
		<cfset setCategoryUID(arguments.categoryUID) />
		<cfset setProductPhotos(arguments.productPhotos) />
		<cfset setCreatedBy(arguments.createdBy) />
	</cffunction>

	<cffunction name="reset" access="public" output="false" returntype="void">
		<cfset setProductUID("") />
		<cfset setProductName("") />
		<cfset setProductDescription("") />
		<cfset setdateCreated("") />
		<cfset setActive(0) />
		<cfset setNumProductPhotos(0) />
		<cfset setCategoryUID("") />
		<cfset setProductPhotos("") />
		<cfset setCreatedBy("") />
	</cffunction>

</cfcomponent>