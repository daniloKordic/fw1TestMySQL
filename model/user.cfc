<cfcomponent displayname="User" output="false">
	
	<cfscript>
		variables.instance.UID = "";
		variables.instance.FirstName = "";
		variables.instance.LastName = "";
		variables.instance.Email = "";
		variables.instance.Username = "";
		variables.instance.Password = "";
		variables.instance.IsActive = 0;
		variables.instance.TypeID = 2;
		variables.instance.UserImage = "";
		variables.instance.address="";
		variables.instance.timezone="";
		variables.instance.phone="";
	</cfscript>

	<cffunction name="init" access="public" output="false" returntype="user">
		<cfreturn this />
	</cffunction>

	<cffunction name="getUser" access="public" output="false" returntype="struct">
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="setUID" access="public" output="false">
		<cfargument name="UID" type="string" required="true" />
		<cfset variables.instance.UID = arguments.UID />
	</cffunction>
	<cffunction name="getUID" access="public" returntype="String" output="false">
		<cfreturn variables.instance.UID />
	</cffunction>

	<cffunction name="setFirstName" access="public" output="false">
		<cfargument name="Firstname" type="string" required="true" />
		<cfset variables.instance.FirstName = arguments.FirstName />
	</cffunction>
	<cffunction name="getFirstName" access="public" returntype="String" output="false">
		<cfreturn variables.instance.FirstName />
	</cffunction>

	<cffunction name="setLastName" access="public" output="false">
		<cfargument name="LastName" type="string" required="true" />
		<cfset variables.instance.LastName = arguments.LastName />
	</cffunction>
	<cffunction name="getLastName" access="public" returntype="String" output="false">
		<cfreturn variables.instance.LastName />
	</cffunction>

	<cffunction name="setEmail" access="public" output="false">
		<cfargument name="Email" type="string" required="true" />
		<cfset variables.instance.Email = arguments.Email />
	</cffunction>
	<cffunction name="getEmail" access="public" returntype="String" output="false">
		<cfreturn variables.instance.Email />
	</cffunction>

	<cffunction name="setUsername" access="public" output="false">
		<cfargument name="Username" type="string" required="true" />
		<cfset variables.instance.Username = arguments.Username />
	</cffunction>
	<cffunction name="getUsername" access="public" returntype="String" output="false">
		<cfreturn variables.instance.Username />
	</cffunction>

	<cffunction name="setPassword" access="public" output="false">
		<cfargument name="Password" type="string" required="true" />
		<cfset variables.instance.Password = arguments.Password />
	</cffunction>
	<cffunction name="getPassword" access="public" returntype="String" output="false">
		<cfreturn variables.instance.Password />
	</cffunction>

	<cffunction name="setIsActive" access="public" output="false">
		<cfargument name="IsActive" type="numeric" required="true" />
		<cfset variables.instance.IsActive = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>

	<cffunction name="setTypeID" access="public" output="false">
		<cfargument name="TypeID" type="numeric" required="true" />
		<cfset variables.instance.TypeID = arguments.TypeID />
	</cffunction>
	<cffunction name="getTypeID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.TypeID />
	</cffunction>

	<cffunction name="setUserImage" access="public" output="false">
		<cfargument name="UserImage" type="string" required="true" />
		<cfset variables.instance.UserImage = arguments.UserImage />
	</cffunction>
	<cffunction name="getUserImage" access="public" returntype="String" output="false">
		<cfreturn variables.instance.UserImage />
	</cffunction>

	<cffunction name="setAddress" access="public" output="false">
		<cfargument name="Address" type="string" required="true" />
		<cfset variables.instance.address = arguments.address />
	</cffunction>
	<cffunction name="getAddress" access="public" returntype="String" output="false">
		<cfreturn variables.instance.address />
	</cffunction>

	<cffunction name="setTimezonee" access="public" output="false">
		<cfargument name="Timezone" type="string" required="true" />
		<cfset variables.instance.timezone = arguments.Timezone />
	</cffunction>
	<cffunction name="getTimezone" access="public" returntype="String" output="false">
		<cfreturn variables.instance.timezone />
	</cffunction>

	<cffunction name="setPhone" access="public" output="false">
		<cfargument name="Phone" type="string" required="true" />
		<cfset variables.instance.phone = arguments.Phone />
	</cffunction>
	<cffunction name="getPhone" access="public" returntype="String" output="false">
		<cfreturn variables.instance.phone />
	</cffunction>

	<cffunction name="setupUser" access="public" output="false" returntype="void">
		<cfargument name="UID" required="false" type="string" default="" />
		<cfargument name="FirstName" required="false" type="string" default="" />
		<cfargument name="LastName" required="false" type="string" default="" />
		<cfargument name="Email" required="false" type="string" default="" />
		<cfargument name="Username" required="false" type="string" default="" />
		<cfargument name="Password" required="false" type="string" default="" />
		<cfargument name="IsActive" required="false" type="numeric" default="0" />
		<cfargument name="TypeID" required="false" type="numeric" default="2" />
		<cfargument name="UserImage" required="false" type="string" default="" />
		<cfargument name="Address" required="false" type="string" default="" />
		<cfargument name="Timezone" required="false" type="string" default="" />
		<cfargument name="Phone" required="false" type="string" default="" />

		<cfset setUID(arguments.UID)>
		<cfset setFirstName(arguments.FirstName)>
		<cfset setLastName(arguments.LastName)>
		<cfset setEmail(arguments.Email)>
		<cfset setUsername(arguments.Username)>
		<cfset setPassword(arguments.Password)>
		<cfset setIsActive(arguments.IsActive)>
		<cfset setTypeID(arguments.TypeID)>
		<cfset setUserImage(arguments.UserImage)>
		<cfset setAddress(arguments.Address)>
		<cfset setTimezonee(arguments.Timezone)>
		<cfset setPhone(arguments.Phone)>
	</cffunction>

	<cffunction name="reset" access="public" output="false" returntype="void">
		<cfset setUID('')>
		<cfset setFirstName('')>
		<cfset setLastName('')>
		<cfset setEmail('')>
		<cfset setUsername('')>
		<cfset setPassword('')>
		<cfset setIsActive(0)>
		<cfset setTypeID(2)>
		<cfset setUserImage('')>
		<cfset setAddress('')>
		<cfset setTimezone('')>
		<cfset setPhone('')>
	</cffunction>

</cfcomponent>