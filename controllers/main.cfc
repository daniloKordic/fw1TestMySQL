<cfcomponent>

	<cfset variables.fw = ""/>
	<cffunction name="init" access="public" returntype="void">
		<cfargument name="fw" type="any" required="true"/>
		<cfset variables.fw = arguments.fw />
	</cffunction>

	<cffunction name="setCategoriesService" access="public" output="false" returntype="void">
		<cfargument name="categoryService" type="any" required="true" />
		<cfset variables.categoryService = arguments.categoryService />		
	</cffunction>
	<cffunction name="getCategoriesService" access="public" output="false" returntype="any">
		<cfreturn variables.categoryService />
	</cffunction>

	<cffunction name="setProductsService" access="public" output="false" returntype="void">
		<cfargument name="productService" type="any" required="true" />
		<cfset variables.productService = arguments.productService />		
	</cffunction>
	<cffunction name="getProductsService" access="public" output="false" returntype="any">
		<cfreturn variables.productService />
	</cffunction>

	<cffunction name="before" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<cfset setCategoriesService(application.beanFactory.getBean('categoryService')) />
		<cfset setProductsService(application.beanFactory.getBean('productService')) />
	</cffunction>
	
	<cffunction name="default">
		<cfargument name="rc" type="struct" required="true" />

		<cfset var categoryService = getCategoriesService() />
		<cfset var productService = getProductsService() />
		<cfset arguments.rc.categories = categoryService.getCategories() />

		<cfif structKeyExists(arguments.rc, "uid")>
			<cfset arguments.rc.products = productService.getProducts(uid=rc.uid) />
		<cfelseif structKeyExists(rc, "cuid")>
			<cfset arguments.rc.products = productService.getProductsByCategory(cuid=rc.cuid) />	
			<cfset arguments.rc.companies = productService.getCompaniesByCategory(cuid=rc.cuid) />
		
		<cfelse>
			<cfset arguments.rc.products = productService.getProducts() />	
		</cfif>
		
	</cffunction>
	
</cfcomponent>
