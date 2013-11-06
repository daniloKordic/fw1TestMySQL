<cfcomponent>
	
	<cfset variables.instance = {} />

	<cffunction name="init" output="false">
		<cfargument name="settings" required="true" type="any" />
		<cfset variables.instance.config = arguments.settings.getConfig() />
		<cfset variables.instance.dsn = variables.instance.config.dsn />
	</cffunction>

	<cffunction name="getDSN" access="private" output="false" returntype="String">
		<cfreturn variables.instance.dsn />
	</cffunction>

	<!--- CREATE --->
	<cffunction name="create" access="public" output="false" returntype="String">
		<cfargument name="product" required="true" type="any" />
		<cfset var qry=""/>
		<cfquery name="qry" datasource="#getDSN()#">
			select newid() as newuid
		</cfquery>
		<cfset var uid = qry.newuid />
		<cfquery name="qry" datasource="#getDSN()#">
			insert into Products (
				ProductUID
				,ProductName
				,ProductDescription
				,dateCreated
				,active
			) values (
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#uid#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductName()#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductDescription()#" />
				,GetDate()
				,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.product.getActive()#" />
			)

			<cfif arguments.product.getCategoryUID neq "">
				insert into Products2CategoriesLookup values (
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#uid#" />
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getCategoryUID()#" />
				)	
			</cfif>
			
		</cfquery>
		<cfreturn uid />
	</cffunction>

	<!--- UPDATE --->
	<cffunction name="update" access="public" output="false" returntype="String">
		<cfargument name="product" required="true" type="any" />
		<cfset var qry=""/>
		<cfset var uid = arguments.product.getProductUID() />
		<cfquery name="qry" datasource="#getDSN()#">
			update Products set
				ProductName=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductName()#" />
				,ProductDescription=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductDescription()#" />
				,active=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.product.getActive()#" />
			where
				ProductUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductUID()#" />

			delete from Products2CategoriesLookup where ProductUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductUID()#" />
			<cfif arguments.product.getCategoryUID() neq "">
				insert into Products2CategoriesLookup values (
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductUID()#" />
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getCategoryUID()#" />
				)	
			</cfif>
		</cfquery>

		<cfreturn uid />
	</cffunction>

	<!--- SAVE --->
	<cffunction name="save" access="public" output="false" returntype="String">
		<cfargument name="product" required="true" type="any" />
		<cfset var uid = ""/>
		<cfif len(arguments.product.getProductUID())>
			<cfset var uid = update(product=arguments.product) />
		<cfelse>
			<cfset var uid = create(product=arguments.product) />
		</cfif>
		<cfreturn uid />
	</cffunction>

	<!--- READ --->
	<cffunction name="getGrid" access="public" output="false" returntype="Query">
		<cfargument name="grid" type="any" required="true" />

		<cfset var qry = "" />

		<cfquery name="qry" datasource="#getDSN()#">
			select
				p.*
			from
				Products p with (nolock)
		</cfquery>

		<cfreturn qry />
	</cffunction>

	<cffunction name="getByKey" access="public" output="false" returntype="any">
		<cfargument name="uid" type="any" required="true" />
		<cfset qry = ""/>
		<cfset var product = createObject("component", "model.product").init() />

		<cfif arguments.uid neq "">
			<cfquery name="qry" datasource="#getDSN()#">
				select
					p.ProductUID
					,p.ProductName
					,p.productDescription
					,p.dateCreated
					,p.active
					,CategoryUID=(select CategoryUID from Products2CategoriesLookup where ProductUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uid#" />)
				from
					Products p with (nolock)
				where
					1=1
					and p.ProductUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uid#" />
			</cfquery>	

			<cfif qry.recordCount eq 1>
				<cfset product.setupProduct(
					productUID=qry.ProductUID
					,productName=qry.ProductName
					,productDescription=qry.ProductDescription
					,dateCreated=qry.dateCreated
					,categoryUID=qry.CategoryUID
					,active=qry.active
				) />
			</cfif>
		</cfif>		

		<cfreturn product />
	</cffunction>

	<cffunction name="getByFilter" access="public" output="false" returntype="Query">
		<cfargument name="filter" required="false" type="struct" default="#structNew()#" />
		<cfset var qry=""/>
		<cfquery name="qry" datasource="#getDSN()#">
			select
				p.*
			from
				Products p with (nolock)
			where
				1=1
				<cfif structKeyExists(arguments.filter, "ProductName") and len(arguments.filter.productName)>
					and p.ProductName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.productName#" />
				</cfif>
		</cfquery>
		
		<cfreturn qry />
	</cffunction>

	<cffunction name="getProducts" output="false" access="public" returntype="query">
		<cfargument name="uid" type="string" required="false" default="" />
		<cfset var qry=""/>

		<cfquery name="qry" datasource="#getDSN()#">
			select * from (
				select
					p.ProductUID
					,p.ProductName
					,p.ProductDescription
					,p.active				
					,CategoryUID=(select CategoryUID from Products2CategoriesLookup p2c with (nolock) where p2c.ProductUID=p.ProductUID)
				from
					Products p with (nolock)
				<cfif arguments.uid neq "">
					where
						1=1
						and p.ProductUID in (select ProductUID from Products2CategoriesLookup where CategoryUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uid#" />)
				</cfif>
			) tbl
			where
				tbl.active = 1
		</cfquery>
		<cfreturn qry />
	</cffunction>

	<cffunction name="getCategories" output="false" access="public" returntype="query">
		<cfset var qry=""/>

		<cfquery name="qry" datasource="#getDSN()#">
			select * from (
				select
					c.CategoryUID
					,c.CategoryName
					,hasChildren=(select count(CategoryUID) from Categories ca with (nolock) where ca.ParentUID=c.CategoryUID)
				from
					Categories c with (nolock)
			) tbl
			where
				tbl.hasChildren = 0
		</cfquery>

		<cfreturn qry />
	</cffunction>

	<!--- DELETE --->
	<cffunction name="delete" access="public" output="false" returntype="Numeric">
		<cfargument name="product" required="true" type="any" />
		<cfset qry=""/>

		<cfquery name="qry" datasource="#getDSN()#">
			delete from Products where ProductUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductUID()#" />
			delete from Products2CategoriesLookup where ProductUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductUID()#"/>				
		</cfquery>

		<cfreturn 1 />
	</cffunction>

</cfcomponent>