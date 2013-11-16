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
		<cfargument name="rc" type="struct" required="true" />
		
		<cfset var menuService = getMenuService() />
		<cfset arguments.rc.menu = menuService.getMenu() />
	</cffunction>

	<cffunction name="manage" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<cfif structKeyExists(rc, "fsw") and Len(rc.fsw)>
			<cfset arguments.rc.event = menuService.HandleForm(form) />
		<cfelse>
 			<cfset arguments.rc.event = menuService.HandleRequest(url) />
		</cfif>

		<cfif structKeyExists(arguments.rc, "fsw") and (arguments.rc.fsw eq "delete" or arguments.rc.fsw eq "save" or arguments.rc.fsw eq "update") >
			<cfset variables.fw.redirect("menu", "event") />			
		</cfif>
	</cffunction>

</cfcomponent>