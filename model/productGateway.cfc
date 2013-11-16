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
			select  uuid() as newuid
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
				'#uid#'
				,'#arguments.product.getProductName()#'
				,'#arguments.product.getProductDescription()#'
				,NOW()
				,#arguments.product.getActive()#
			);			
		</cfquery>

		<cfif arguments.product.getCategoryUID() neq "">
			<cfquery name="qInsertLookups" datasource="#getDSN()#">
				insert into Products2CategoriesLookup (ProductUID, CategoryUID) values (
					'#uid#'
					,'#arguments.product.getCategoryUID()#'
				);
			</cfquery>					
		</cfif>

		<cfif arguments.product.getProductPhotos() neq "">
			<cfset imagesList = arguments.product.getProductPhotos() />

			<cfloop list="#imagesList#" index="i">
				<cfquery name="qInsertProductPhotos" datasource="#getDSN()#">
					insert into ProductImages (ProductImageUID, ProductUID, ImageFile) values (
						uuid()
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#uid#" />
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#i#" />
					);
				</cfquery>
			</cfloop>
		</cfif>

		
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
				ProductUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductUID()#" />;
		</cfquery>


		<cfif arguments.product.getCategoryUID() neq "">
			<cfquery name="qDeleteLookup" datasource="#getDSN()#">
				delete from Products2CategoriesLookup where ProductUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductUID()#" />;
			</cfquery>
			<cfquery name="qInsertLookups" datasource="#getDSN()#">
				insert into Products2CategoriesLookup (ProductUID, CategoryUID) values (
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getProductUID()#" />
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.product.getCategoryUID()#" />
				);
			</cfquery>				
		</cfif>

		<cfif arguments.product.getProductPhotos() neq "">
			<cfset imagesList = arguments.product.getProductPhotos() />
			
			<cfloop list="#imagesList#" index="i">
				<cfquery name="qInsertProductPhotos" datasource="#getDSN()#">					
					insert into ProductImages (ProductImageUID, ProductUID, ImageFile) values (
						uuid()
						,'#arguments.product.getProductUID()#'
						,'#i#'
					);
				</cfquery>
			</cfloop>				

		</cfif>

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
				Products p  
		</cfquery>

		<cfreturn qry />
	</cffunction>

	<cffunction name="getByKey" access="public" output="false" returntype="any">
		<cfargument name="uid" type="any" required="true" />
		<cfset qry = ""/>
		<cfset var product = createObject("component", "fw1Test.model.product").init() />

		<cfif arguments.uid neq "">
			<cfquery name="qry" datasource="#getDSN()#">
				select
					p.ProductUID
					,p.ProductName
					,p.productDescription
					,p.dateCreated
					,p.active
					,(select CategoryUID from Products2CategoriesLookup where ProductUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uid#" />) as CategoryUID
				from
					Products p  
				where
					1=1
					and p.ProductUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uid#" />
			</cfquery>	

			<cfquery name="qProductImages" datasource="#getDSN()#">
				select
					ImageFile
				from
					ProductImages
				where
					ProductUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uid#" />	
			</cfquery>

			<cfif qry.recordCount eq 1>
				<cfset product.setupProduct(
					productUID=qry.ProductUID
					,productName=qry.ProductName
					,productDescription=qry.ProductDescription
					,dateCreated=qry.dateCreated
					,categoryUID=qry.CategoryUID
					,productPhotos=valueList(qProductImages.ImageFile,',')
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
				Products p  
			where
				1=1
				<cfif structKeyExists(arguments.filter, "ProductName") and len(arguments.filter.productName)>
					and p.ProductName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.productName#" />
				</cfif>
		</cfquery>
		
		<cfreturn qry />
	</cffunction>

	<cffunction name="getProducts" output="false" access="public" returntype="query">
		<cfargument name="uid" type="String" required="false" default="" />	
		<cfargument name="count" type="numeric" required="false" default="0" />
		<cfset var qry=""/>

		<cfquery name="qry" datasource="#getDSN()#">
			SELECT 
				p.ProductUID
				,p.ProductName
				,p.ProductDescription
				,p.active
				,(SELECT CategoryUID
					FROM Products2CategoriesLookup
					WHERE ProductUID = p.ProductUID
					) AS CategoryUID
				,(SELECT ImageFile
					FROM ProductImages
					WHERE ProductUID = p.ProductUID
					LIMIT 1
				) AS mainImage
			FROM 
				Products p
			WHERE 
				p.active =1
				<cfif arguments.uid neq "">
					and p.ProductUID in (select ProductUID from Products2CategoriesLookup where CategoryUID='#arguments.uid#')
				</cfif>
			<cfif arguments.count neq 0>
				limit #arguments.count#
			</cfif>
		</cfquery>
		<cfreturn qry />
	</cffunction>

	<cffunction name="getByUID" output="false" access="public" returntype="query">
		<cfargument name="uid" type="String" required="false" default="" />		
		<cfset var qry=""/>

		<cfquery name="qImages" datasource="#getDSN()#">
			select
				ImageFile
			from
				ProductImages
			where
				ProductUID='#arguments.uid#'
		</cfquery>

		<cfset imagesList = valueList(qImages.ImageFile) />

		<cfquery name="qry" datasource="#getDSN()#">
			select 
				tbl.*
				,'#imagesList#' as images
			from (			
			select
				p.ProductUID
				,p.ProductName
				,p.ProductDescription
				,p.active
				,(select CategoryUID from Products2CategoriesLookup where ProductUID=p.ProductUID) as CategoryUID
				,(select ImageFile from ProductImages where ProductUID = p.ProductUID limit 1) as mainImage
			from
				Products p			
			) tbl
			where
				1=1
				<cfif arguments.uid neq "">
					and tbl.ProductUID = '#arguments.uid#'
				</cfif>
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
					,(select count(CategoryUID) from Categories ca   where ca.ParentUID=c.CategoryUID) as hasChildren
				from
					Categories c  
			) tbl
			where
				tbl.hasChildren = 0
		</cfquery>

		<cfreturn qry />
	</cffunction>

	<cffunction name="getByCategory" output="false" access="public" returntype="query">
		<cfargument name="cuid" type="String" required="false" default="" />		
		<cfset var qry=""/>

		<cfquery name="qry" datasource="#getDSN()#">
			
			SELECT 
				tbl.*
				,'' as images
			from (			
			select
				p.ProductUID
				,p.ProductName
				,p.ProductDescription
				,p.active
				,p.datecreated
				,(select CategoryUID from Products2CategoriesLookup where ProductUID=p.ProductUID) as CategoryUID
				,(select ImageFile from ProductImages where ProductUID = p.ProductUID limit 1) as mainImage
			from
				Products p
			) tbl
			where
				1=1
				<cfif arguments.cuid neq "">
					and tbl.CategoryUID = '#arguments.cuid#'
				</cfif>
		</cfquery>
		<cfreturn qry />
	</cffunction>

	<!--- DELETE --->
	<cffunction name="delete" access="public" output="false" returntype="Numeric">
		<cfargument name="product" required="true" type="any" />
		<cfset qry=""/>

		<cfquery name="qry" datasource="#getDSN()#">
			delete from Products where ProductUID = '#arguments.product.getProductUID()#';
		</cfquery>
		<cfquery name="qry" datasource="#getDSN()#">
			delete from Products2CategoriesLookup where ProductUID='#arguments.product.getProductUID()#';
		</cfquery>
		<cfquery name="qry" datasource="#getDSN()#">
			delete from ProductImages where ProductUID='#arguments.product.getProductUID()#';
		</cfquery>

		<cfreturn 1 />
	</cffunction>

</cfcomponent>