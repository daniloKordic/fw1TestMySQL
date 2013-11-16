<cfcomponent>
	
	<cfset variables.fw = "" />

	<cffunction name="init">
		<cfargument name="fw"/>

		<cfset variables.fw = arguments.fw />
	</cffunction>

	<cffunction name="setCategoryService" access="public" output="false" returntype="void">
		<cfargument name="categoryService" type="any" required="true" />
		<cfset variables.categoryService=arguments.categoryService />
	</cffunction>
	<cffunction name="getCategoryService" access="public" output="false" returntype="any">
		<cfreturn variables.categoryService />	
	</cffunction>

	<cffunction name="before" access="public" returntype="void">
		<cfset setCategoryService(application.beanFactory.GetBean('categoryService')) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void">
		<cfset var categoryService = getCategoryService() />
		<cfset rc.qGrid = categoryService.handleGrid(url) />
	</cffunction>

	<cffunction name="manage" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<cfset var categoryService = getCategoryService() />

		<cfif structKeyExists(arguments.rc, "fsw") and Len(arguments.rc.fsw)>
			<cfset arguments.rc.event = categoryService.HandleForm(form) />
		<cfelse>
			<cfset arguments.rc.event = categoryService.HandleRequest(url) />
		</cfif>

		<cfif structKeyExists(arguments.rc, "fsw") and (arguments.rc.fsw eq "delete" or arguments.rc.fsw eq "save" or arguments.rc.fsw eq "update")>
			<cfset variables.fw.redirect("categories","event") />
		</cfif>
	</cffunction>

</cfcomponent>