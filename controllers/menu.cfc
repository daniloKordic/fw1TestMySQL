<cfcomponent>
	
	<cfset variables.fw = ""/>
	<cffunction name="init" access="public" returntype="void">
		<cfargument name="fw" type="any" required="true"/>
		<cfset variables.fw=arguments.fw />
	</cffunction>

	<cffunction name="setMenuService" access="public" output="false" returntype="void">
		<cfargument name="menuService" type="any" required="true"/>
		<cfset variables.menuService = arguments.menuService />
	</cffunction>
	<cffunction name="getMenuService" access="public" output="false" returntype="any">
		<cfreturn variables.menuService />
	</cffunction>

	<cffunction name="before" access="public" returntype="void">
		<cfset setMenuService(application.beanFactory.GetBean('menuService')) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void">
		<cfset var menuService = getMenuService() />
		<cfset rc.menu = menuService.getMenu() />
	</cffunction>

	<cffunction name="manage" access="public" returntype="void">

		<cfif structKeyExists(rc, "fsw") and Len(rc.fsw)>
			<cfset var rc.event = menuService.HandleForm(form) />
		<cfelse>
 			<cfset var rc.event = menuService.HandleRequest(url) />
		</cfif>

		<cfif structKeyExists(rc, "fsw") and (rc.fsw eq "delete" or rc.fsw eq "save" or rc.fsw eq "update") >
			<cfset variables.fw.redirect("menu", "event") />			
		</cfif>
	</cffunction>

</cfcomponent>