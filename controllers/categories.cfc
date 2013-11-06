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
		
		<cfset var categoryService = getCategoryService() />

		<cfif structKeyExists(rc, "fsw") and Len(rc.fsw)>
			<cfset var rc.event = categoryService.HandleForm(form) />
		<cfelse>
			<cfset var rc.event = categoryService.HandleRequest(url) />
		</cfif>

		<cfif structKeyExists(rc, "fsw") and (rc.fsw eq "delete" or rc.fsw eq "save" or rc.fsw eq "update")>
			<cfset variables.fw.redirect("categories","event") />
		</cfif>
	</cffunction>

</cfcomponent>