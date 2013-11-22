<cfcomponent displayname="User Gateway" output="false">
	
	<cfset variables.instance = {} />

	<cffunction name="init" output="false">
		<cfargument name="settings" required="true" type="any">

		<cfset variables.instance.config = arguments.settings.getConfig() />
		<cfset variables.instance.dsn = variables.instance.config.dsn />
		<cfreturn this />
	</cffunction>

	<cffunction name="getDSN" access="private" output="false" returntype="String">
		<cfreturn variables.instance.dsn />
	</cffunction>

	<cffunction name="getGrid" access="public" output="false" returntype="query">
		<cfargument name="grid" type="any" required="true" />
		<cfset var qry = ""/>
		<cfquery name="qry" datasource="#getDSN()#">
			select
				u.*
			from
				Users u 
		</cfquery>

		<cfreturn qry />
	</cffunction>

	<cffunction name="getByFilter" access="public" output="false" returntype="query">
		<cfargument name="filter" required="false" type="struct" default="#structNew()#" />
		<cfset var qry = ""/>

		<cfquery name="qry" datasource="#getDSN()#">
			select
				*
			from
				Users
			where
				1=1
				<cfif structKeyExists(arguments.filter,"uid") and len(arguments.filter.uid)>
					and userUID
					<cfif structKeyExists(arguments.filter,"uidSign") and len(arguments.filter.uidSign)>
						#arguments.filter.uidSign#
					<cfelse>
						=
					</cfif>
					'#arguments.filter.uid#'
				</cfif>
				<cfif structKeyExists(arguments.filter,"email") and len(arguments.filter.email)>
					and email = '#arguments.filter.email#'
				</cfif>
				<cfif structKeyExists(arguments.filter,"username") and len(arguments.filter.username)>
					and username = '#arguments.filter.username#'
				</cfif>
		</cfquery>
		
		<cfreturn qry />
	</cffunction>

	<cffunction name="getByKey" access="public" output="false" returntype="Any">
		<cfargument name="uid" required="true" type="any" />

		<cfset var qry=""/>
		<cfset var user = createObject("component","fw1Test.model.user").init() />

		<cfif arguments.uid neq "">
			<cfquery name="qry" datasource="#getDSN()#">
				select
					u.*
				from
					Users u 
				where
					userUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uid#" />
			</cfquery>
			<cfif qry.recordCount eq 1>
				<cfset user.setupUser(
					UID = qry.userUID
					,FirstName=qry.FirstName
					,LastName=qry.LastName
					,email=qry.email
					,username=qry.username
					,password=qry.password
					,isActive=qry.isActive
					,TypeID=qry.TypeID
					,UserImage=qry.UserImage
					,Address=qry.Address
					,Timezone=qry.Timezone
					,Phone=qry.phone
					,TypeID=qry.typeID
					) />
			</cfif>
		</cfif>

		<cfreturn user />
	</cffunction>

	<cffunction name="getByEmail" access="public" output="false" returntype="any">
		<cfargument name="email" required="true" type="string" />
		<cfset var qry="" />
		<cfset var user = createObject("component","fw1Test.model.user").init() />
		<cfif arguments.email neq "">
			<cfquery name="qry" datasource="#getDSN()#">
				select
					 u.userUID
					,u.FirstName
					,u.LastName
					,u.email
					,u.username
					,u.password
					,u.isActive
					,u.typeID
					,u.userImage
					,u.Address
					,u.phone
					,u.Timezone
				from
					Users u 
				WHERE
					u.email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#" />
					and u.isActive=1
			</cfquery>

			<cfif qry.recordCount eq 1>
				<cfset user.setupUser(
					UID=qry.userUID,
					FirstName=qry.FirstName,
					LastName=qry.LastName,
					Email=qry.email,
					Username=qry.username,
					Password=qry.password,
					IsActive=qry.isActive,
					TypeID=qry.typeID,
					UserImage=qry.userImage,
					Address=qry.Address,
					Timezone=qry.Timezone,
					Phone=qry.phone
				) />
			</cfif>
		</cfif>
		
		<cfreturn user />
	</cffunction>

	<!--- CREATE --->
	<cffunction name="create" access="public" output="false" returntype="string">
		<cfargument name="user" required="true" type="any" />
		<cfset var qry=""/>
		<cfquery name="qry" datasource="#getDSN()#">
			select uuid() as newUID
		</cfquery>
		<cfset var uid = qry.newUID/>

		<cfquery name="qry" datasource="#getDSN()#">
			insert into Users (
				 userUID
				,FirstName
				,LastName
				,email
				,username
				,password
				,isActive
				,typeID
				,userImage
				,Address
				,Timezone
				,phone
			) values(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#uid#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getFirstname()#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getLastName()#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getEmail()#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getUsername()#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getPassword()#" />
				,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getIsActive()#" />
				,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getTypeID()#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getUserImage()#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getAddress()#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getTimezone()#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getPhone()#" />
			)
		</cfquery>

		<cfreturn uid />
	</cffunction>

	<!--- UPDATE --->
	<cffunction name="update" access="public" output="false" returntype="string">
		<cfargument name="user" required="true" type="any" />
		<cfset var qry=""/>
		<cfset var uid = arguments.user.getUID() />
		<cfquery name="qry" datasource="#getDSN()#">
			UPDATE Users SET
			 FirstName=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getFirstName()#" />
			,Lastname=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getLastName()#" />
			,email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getEmail()#" />
			,username=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getUsername()#" />
			,password=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getPassword()#" />
			,isActive=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getIsActive()#" />
			,userImage=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getUserImage()#" />
			,address=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getAddress()#" />
			,timezone=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getTimezone()#" />
			,phone=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getPhone()#" />
			,typeID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getTypeID()#" />
			WHERE UserUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getUID()#" />
		</cfquery>

		<cfreturn uid />
	</cffunction>

	<!--- SAVE --->
	<cffunction name="save" access="public" output="false" returntype="string">
		<cfargument name="user" required="true" type="any" />
		<cfset var uid=""/>

		<cfif len(arguments.user.getUID())>
			<cfset var uid = update(user=arguments.user) />
		<cfelse>
			<cfset var uid = create(user=arguments.user) />
		</cfif>

		<cfreturn uid />
	</cffunction>

	<!--- DELETE --->
	<cffunction name="delete" output="false" access="public" returntype="numeric">
		<cfargument name="user" required="true" type="any" />
		<cfset qry=""/>

		<cfquery name="qry" datasource="#getDSN()#">
			delete from Users where useruid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getUID()#" />
		</cfquery>

		<cfreturn 1 />
	</cffunction>

	<!--- CONFIRM ACCOUNT --->
	<cffunction name="confirmAccount" output="false" access="public" returntype="string">
		<cfargument name="userUID" required="true" default="" />
		<cfset var result = ""/>

		<cfquery name="confirmAccount" datasource="#getDSN()#">
			update Users
			set isActive=1
			where userUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userUID#" />
		</cfquery>

		<cfset var result = "User account activated!"/>

		<cfreturn result />
	</cffunction>

	<cffunction name="qSelect" output="false" returntype="any" access="public" >
		
		<cfscript>
			var qGetQery="";
			var qres="";
			var res={QUERYRESULT=false};
		</cfscript>		
		
		<cfquery name="qGetQery" datasource="#variables.DevDSN#">
			select top(1) Sql  FROM Table_Query where name='#arguments.qKey#'
		</cfquery>
		
		<cfif qGetQery.recordCount eq 1>
			<cfset qres="#qGetQery.Sql#">
			
			<cfloop list="#structKeyList(qParamsStruct)#" index="key">
<!--- 
				<cfset qres=ReplaceNoCase(qres,"$#key#","#qParamsStruct[key]#","All") >
 --->
				<cfset qres=ReplaceNoCase(qres,"$#key#",ReplaceNoCase("#qParamsStruct[key]#","'","''","All"),"All") >
				
			</cfloop>
			
			<cfif qDebug eq 1>
				<cfset StructAppend(res, {QUERYTEXT="#qres#"}, true) >
			</cfif>

			<cfquery name="qGetQery" datasource="#variables.DevDSN#">
				#PreserveSingleQuotes(qres)#
			</cfquery>
			<cfif IsDefined("qGetQery.recordCount") and qGetQery.recordCount gt 0>
				<cfset StructAppend(res,QueryToStruct(qGetQery), true) >
				<cfset StructAppend(res,{QUERYRESULT=true}, true) >
			</cfif>
		</cfif>

<!--- 
		<cf_ftdebugger file="c:/temp/somefile.txt" output="out from productconceptgateway.qselect (#qKey# #SerializeJSON(qParamsStruct)#): #SerializeJSON(res)#">
 --->
		<cfreturn res />
	</cffunction>
</cfcomponent>