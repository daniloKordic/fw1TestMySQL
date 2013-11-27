<cfcomponent>
	
	<cfset variables.fw = "" />
	<cffunction name="init">
		<cfargument name="fw"/>
		<cfset variables.fw = arguments.fw />
	</cffunction>

	<cffunction name="setUserService" access="public" output="false" returntype="void">
		<cfargument name="userService" type="any" required="true"/>
		<cfset variables.userService=arguments.userService/>
	</cffunction>
	<cffunction name="getUserService" access="public" output="false" returntype="any">
		<cfreturn variables.userService />
	</cffunction>
	<cffunction name="setProductService" access="public" output="false" returntype="void">
		<cfargument name="productService" type="any" required="true" />
		<cfset variables.productService=arguments.productService />
	</cffunction>
	<cffunction name="getProductService" access="public" output="false" returntype="Any">
		<cfreturn variables.productService />
	</cffunction>

	<cffunction name="before" access="public" returntype="void">
		<cfset setProductService(application.beanFactory.GetBean('productService')) />
		<cfset setUserService(application.beanFactory.GetBean('userService')) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<cfset var productService = getProductService() />
	</cffunction>

	<cffunction name="view" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />
		
		<cfset var userService = getUserService() />
		<cfset var productService = getProductService() />

		<cfif structKeyExists(arguments.rc, "uid")>
			<cfset arguments.rc.company = userService.getByUID(uid=rc.uid) />			
			<cfif structKeyExists(arguments.rc, "cuid")>
				<cfset arguments.rc.products = productService.getProductsByCategory(cuid=arguments.rc.cuid,uid=arguments.rc.uid) />
			<cfelse>
				<cfset arguments.rc.products = productService.getProductsByCategory(uid=arguments.rc.uid) />
			</cfif>
		</cfif>
		
	</cffunction>


</cfcomponent>