<cfcomponent displayname="Category Gateway" output="false">
	
	<cfset variables.instance = {} />

	<cffunction name="init" output="false">
		<cfargument name="settings" required="true" type="any" />

		<cfset variables.instance.config = arguments.settings.getConfig() />
		<cfset variables.instance.dsn = variables.instance.config.dsn />
		<cfreturn this />
	</cffunction>

	<cffunction name="getDSN" access="private" output="false" returntype="String">
		<cfreturn variables.instance.dsn />
	</cffunction>

	<cffunction name="create" access="public" output="false" returntype="string">
		<cfargument name="category" required="true" type="any" />
		<cfset var qry=""/>

		<cfquery name="qry" datasource="#getDSN()#">
			select  uuid() as newUID
		</cfquery>
		<cfset var uid = qry.newUID />

		<cfquery name="qry"  datasource="#getDSN()#">
			insert into Categories (
				CategoryUID
				,CategoryName
				,CategoryDetails
				,ParentUID
				,DateCreated
				,DateUpdated
				,sort
			) values (
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#uid#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.category.getCategoryName()#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.category.getCategoryDetails()#" />
				<cfif arguments.category.getParentUID() eq "">
					,NULL
				<cfelse>
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.category.getParentUID()#" />					
				</cfif>
				,NOW()
				,NULL
				,<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.category.getSort()#" />
			)
		</cfquery>

		<cfreturn uid />
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="string">
		<cfargument name="category" required="true" type="any" />
		<cfset var qry=""/>
		<cfset var uid = arguments.category.getCategoryUID() />

		<cfquery name="qry" datasource="#getDSN()#">
			update Categories set
				CategoryName=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.category.getCategoryName()#" />
				<cfif arguments.category.getCategoryDetails() neq "">
					,CategoryDetails=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.category.getCategoryDetails()#" />
				<cfelse>
					,CategoryDetails=NULL
				</cfif>				
				<cfif arguments.category.getParentUID() neq "">					
					,ParentUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.category.getParentUID()#" />
				<cfelse>
					,ParentUID=NULL
				</cfif>
				,DateUpdated=NOW()
				,sort=<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.category.GetSort()#" />
			where CategoryUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.category.getCategoryUID()#" />
		</cfquery>

		<cfreturn uid />
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="string">
		<cfargument name="category" required="true" type="any" />
		<cfset var uid = ""/>

		<cfif len(arguments.category.getCategoryUID())>
			<cfset var uid = update(category = arguments.category) />
		<cfelse>
			<cfset var uid = create(category=arguments.category) />
		</cfif>

		<cfreturn uid />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="string">
		<cfargument name="category" required="true" type="any" />
		<cfset var qry = "" />

		<cfquery name="qry" datasource="#getDSN()#">
			delete from Categories where CategoryUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.category.getCategoryUID()#" />
		</cfquery>

		<cfreturn 1 />
	</cffunction>

	<cffunction name="getGrid" access="public" output="false" returntype="query">
		<cfargument name="grid" type="any" required="true" />
		<cfset var qry = ""/>
		<cfquery name="qry" datasource="#getDSN()#">
			select
				c.*
				,(select CategoryName from Categories cc where  cc.CategoryUID=c.ParentUID) as Parent
				,(select count(categoryUID) from Categories ccc where ccc.ParentUID = c.CategoryUID) as hasChildren
			from
				Categories c  
			order by
				c.sort
		</cfquery>

		<cfreturn qry />
	</cffunction>

	<cffunction name="getByKey" access="public" output="false" returntype="Any">
		<cfargument name="uid" required="true" type="any" />

		<cfset var qry=""/>
		<cfset var category = createObject("component","model.category").init() />

		<cfif arguments.uid neq "">
			<cfquery name="qry" datasource="#getDSN()#">
				select
					c.CategoryUID
					,c.CategoryName
					,c.CategoryDetails
					,c.ParentUID
					,c.DateCreated
					,c.DateUpdated
					,coalesce(c.Sort, 0) as sort
				from
					Categories c  
				where
					CategoryUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uid#" />
			</cfquery>
			<cfif qry.recordCount eq 1>
				<cfset category.setupCategory(
					 CategoryUID = qry.CategoryUID
					,CategoryName=qry.CategoryName
					,CategoryDetails=qry.CategoryDetails
					,ParentUID=qry.ParentUID
					,DateCreated=qry.DateCreated
					,DateUpdated=qry.DateUpdated
					,Sort=qry.sort
					) />
			</cfif>
		</cfif>

		<cfreturn category />
	</cffunction>

	<cffunction name="getByFilter" access="public" output="false" returntype="query">
		<cfargument name="filter" type="struct" required="true" default="#structNew()#" />
		<cfset var qry=""/>

		<cfquery name="qry" datasource="#getDSN()#">
			select
				c.*
			from
				Categories c  
			where
				1=1
				<cfif structKeyExists(arguments.filter, "CategoryName")and len(arguments.filter.CategoryName)>
					and c.CategoryName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.CategoryName#" />
				</cfif>
		</cfquery>

		<cfreturn qry />
	</cffunction>

	<cffunction name="getAll" access="public" output="false" returntype="query">
		<cfset var qry=""/>
		<cfquery name="qry" datasource="#getDSN()#">
			select
				c.*
				,(select count(categoryUID) from Categories ca where ca.ParentUID=c.CategoryUID) as hasChildren
			from
				Categories c 
			order by
				c.Sort	
		</cfquery>

		<cfreturn qry />
	</cffunction>

</cfcomponent>