<cfcomponent displayname="Category Service" output="false">
	
	<cffunction name="init" output="false">
		<cfargument name="categoryGateway" required="true" type="component"/>
		<cfset variables.instance.categoryGateway=arguments.categoryGateway />
		<cfreturn this />
	</cffunction>

	<cffunction name="getCategoryGateway" access="public" output="false">
		<cfreturn variables.instance.categoryGateway />
	</cffunction>

	<cffunction name="handleGrid" access="public" output="false" returntype="any">
		<cfargument name="url" required="false" type="any" />

		<cfscript>
			var grid = {
				pageNumber=1
				,rowsPerPage = 20
				,orderBy = "CategoryName"
				,orderDirection = "asc"
				,start=0
			};
		</cfscript>

		<cfif structKeyExists(arguments.url, "pageNumber")><cfset grid.pageNumber = arguments.url.pageNumber /></cfif>
		<cfif structKeyExists(arguments.url, "rowsPerPage")><cfset grid.rowsPerPage = arguments.url.rowsPerPage /></cfif>
		<cfif structKeyExists(arguments.url, "orderBy")><cfset grid.orderBy = arguments.url.orderBy /></cfif>
		<cfif structKeyExists(arguments.url, "orderDirection")><cfset grid.orderDirection = arguments.url.orderDirection /></cfif>
		<cfif structKeyExists(arguments.url, "start")><cfset grid.start = arguments.url.start /></cfif>

		<cfreturn getCategoryGateway().getGrid(grid=grid) />
	</cffunction>

	<cffunction name="handleRequest" access="public" output="false" returntype="any">
		<cfargument name="url" type="any" required="true" />

		<cfscript>
			var uid="";
			var result = {
				errorFields=""
				,message=""
			};
		</cfscript>

		<cfif structKeyExists(arguments.url, "uid")><cfset uid=arguments.url.uid /></cfif>

		<cfset var category = getCategoryGateway().getByKey(uid=uid) />
		<cfset var parents = getCategoryGateway().getAll() />
		<cfset var event = {category=category, parents = parents, result=result} />

		<cfreturn event />
	</cffunction>

	<cffunction name="handleForm" access="public" output="false" returntype="any">
		<cfargument name="form" required="true" type="any" default="" />
		
		<cfscript>
			var category = createObject("component","fw1Test.model.category").init();
			var tCategoryUID="";
			var tCategoryName="";
			var tCategoryDetails="";
			var tParentUID="";
			var tSort=0;
		</cfscript>

		<cfif structKeyExists(arguments.form, "CategoryUID")><cfset tCategoryUID=arguments.form.CategoryUID /></cfif>
		<cfif structKeyExists(arguments.form, "CategoryName")><cfset tCategoryName=arguments.form.CategoryName /></cfif>
		<cfif structKeyExists(arguments.form, "CategoryDetails")><cfset tCategoryDetails=arguments.form.CategoryDetails /></cfif>
		<cfif structKeyExists(arguments.form, "ParentUID")><cfset tParentUID=arguments.form.ParentUID /></cfif>
		<cfif structKeyExists(arguments.form, "sort")><cfset tSort=arguments.form.sort /></cfif>

		<cfset category.setupCategory(
			CategoryUID=tCategoryUID
			,CategoryName=tCategoryName
			,CategoryDetails=tCategoryDetails
			,ParentUID=tParentUID
			,Sort=tSort
		) />
		
		<cfif structKeyExists(form, "fsw")>
			<cfswitch expression="#arguments.form.fsw#">
				<cfcase value="save">
					
					<cfset filter = {
						CategoryName = category.getCategoryName()
					} />
					
					<cfset qHowMany = getCategoryGateway().getByFilter(filter = filter) />

					<cfif qHowMany.recordCount eq 0>
						<cfset var newCategoryUID = getCategoryGateway().save(category = category) />
						<cfset result.message = "Category Successfully Saved!" />
					<cfelse>
						<cfset category.reset() />
						<cfset result.message = "Duplicate Category found!" />
					</cfif>
				</cfcase>
				<cfcase value="update">
					<cfset var rezultat = getCategoryGateway().save(category = category) />
					<cfif rezultat neq "">
						<cfset result.message = "Category Successfully Updated!" />
					</cfif>
				</cfcase>
				<cfcase value="delete">
					<cfset rezultat = getCategoryGateway().delete(category=category) />
					<cfif rezultat eq 1>
						<cfset result.message = "Category Successfully Deleted!" />
					</cfif>
				</cfcase>
			</cfswitch>
		</cfif>

		<cfset var event = {
			category = category
			,result = result
			,parents = getCategoryGateway().getAll()		
		} />

		<cfreturn event />

	</cffunction>

	<cffunction name="getCategories" access="public" output="false" returntype="any">
		<cfset var categories=""/>

		<cfset categories = getCategoryGateway().getAll() />

		<cfreturn categories />
	</cffunction>
</cfcomponent>