<cfcomponent>
	
	<cfset variables.fw = ""/>
	<cffunction name="init" access="public" returntype="void">
		<cfargument name="fw" type="any" required="true"/>
		<cfset variables.fw = arguments.fw />
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
	</cffunction>

	<cffunction name="default" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<cfset var productService = getProductService() />
		<cfset arguments.rc.qGrid = productService.handleGrid(rc) />
	</cffunction>

	<cffunction name="manage" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<cfset var productService = getProductService() />

		<cfif structKeyExists(arguments.rc, "fsw") and Len(arguments.rc.fsw)>
			<cfset arguments.rc.event = productService.HandleForm(form) />
		<cfelse>
			<cfset arguments.rc.event = productService.HandleRequest(url) />
		</cfif>		

		<cfif structKeyExists(arguments.rc, "fsw") and (arguments.rc.fsw eq "delete" or arguments.rc.fsw eq "save" or arguments.rc.fsw eq "update")>
			<cfset variables.fw.redirect("products","event") />
		</cfif>
	</cffunction>

	<cffunction name="view" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<cfset var productService = getProductService() />

		<cfif structKeyExists(arguments.rc, "uid")>
			<cfset arguments.rc.product = productService.getProducts(uid=arguments.rc.uid) />					
		</cfif>
	</cffunction>

	<cffunction name="test" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<cfset var productService = getProductService() />

		<cfif structKeyExists(arguments.rc, "uid")>
			<cfset arguments.rc.product = productService.getProducts(uid=arguments.rc.uid) />					
		</cfif>
	</cffunction>

	<cffunction name="product" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="false" />

		<cfset var productService = getProductService() />

		<cfif structKeyExists(arguments.rc, "puid")>
			<cfset arguments.rc.product = productService.getByUID(uid=arguments.rc.puid) />
		</cfif>
	</cffunction>
</cfcomponent>