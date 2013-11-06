<cfcomponent displayname="Menu" output="false">
	
	<cfscript>
		variables.instance.menuItemUID="";
		variables.instance.menuTitle="";
		variables.instance.menuAction="";
		variables.instance.menuItemLevel=0;
		variables.instance.parentMenuItemUID="";
		variables.instance.sort=0;
		variables.instance.pageUID="";
		variables.instance.hasChildren=0;	
	</cfscript>

	<cffunction name="init" access="public" output="false" returntype="menu">
		<cfreturn this />
	</cffunction>

	<cffunction name="getMenuItem" access="public" output="false" returntype="struct">
		<cfreturn variables.instance />	
	</cffunction>

	<cffunction name="setMenuItemUID" access="public" output="false">
		<cfargument name="menuItemUID" required="true" type="string" />
		<cfset variables.instance.menuItemUID=arguments.menuItemUID />
	</cffunction>
	<cffunction name="getMenuItemUID" access="public" output="false" returntype="string">
		<cfreturn variables.instance.menuItemUID />
	</cffunction>

	<cffunction name="setMenuTitle" access="public" output="false">
		<cfargument name="menuTitle" required="true" type="string" />
		<cfset variables.instance.menuTitle=arguments.menuTitle />
	</cffunction>
	<cffunction name="getMenuTitle" access="public" output="false" returntype="string">
		<cfreturn variables.instance.menuTitle />
	</cffunction>

	<cffunction name="setMenuAction" access="public" output="false">
		<cfargument name="menuAction" required="true" type="string" />
		<cfset variables.instance.menuAction=arguments.menuAction />
	</cffunction>
	<cffunction name="getMenuAction" access="public" output="false" returntype="string">
		<cfreturn variables.instance.menuAction />
	</cffunction>

	<cffunction name="setMenuItemLevel" access="public" output="false">
		<cfargument name="menuItemLevel" required="true" type="numeric" />
		<cfset variables.instance.menuItemLevel=arguments.menuItemLevel />
	</cffunction>
	<cffunction name="getMenuItemLevel" access="public" output="false" returntype="numeric">
		<cfreturn variables.instance.menuItemLevel />
	</cffunction>

	<cffunction name="setParentMenuItemUID" access="public" output="false">
		<cfargument name="parentMenuItemUID" required="true" type="string" />
		<cfset variables.instance.parentMenuItemUID=arguments.parentMenuItemUID />
	</cffunction>
	<cffunction name="getParentMenuItemUID" access="public" output="false" returntype="string">
		<cfreturn variables.instance.parentMenuItemUID />
	</cffunction>

	<cffunction name="setSort" access="public" output="false">
		<cfargument name="sort" required="true" type="numeric" />
		<cfset variables.instance.sort=arguments.sort />
	</cffunction>
	<cffunction name="getSort" access="public" output="false" returntype="numeric">
		<cfreturn variables.instance.sort />
	</cffunction>

	<cffunction name="setPageUID" access="public" output="false">
		<cfargument name="pageUID" required="true" type="string" />
		<cfset variables.instance.pageUID=arguments.pageUID />
	</cffunction>
	<cffunction name="getPageUID" access="public" output="false" returntype="string">
		<cfreturn variables.instance.pageUID />
	</cffunction>

	<cffunction name="setHasChildren" access="public" output="false">
		<cfargument name="hasChildren" required="true" type="numeric" />
		<cfset variables.instance.hasChildren=arguments.hasChildren />
	</cffunction>
	<cffunction name="getHasChildren" access="public" output="false" returntype="numeric">
		<cfreturn variables.instance.hasChildren />
	</cffunction>

	<cffunction name="setupMenuItem" access="public" output="false" returntype="void">
		<cfargument name="menuItemUID" required="false" default="" type="string" />
		<cfargument name="menuTitle" required="false" default="" type="string" />
		<cfargument name="menuAction" required="false" default="" type="string" />
		<cfargument name="menuItemLevel" required="false" default="0" type="numeric" />
		<cfargument name="parentMenuItemUID" required="false" default="" type="string" />
		<cfargument name="sort" required="false" default="0" type="numeric" />
		<cfargument name="pageUID" required="false" default="" type="string" />
		<cfargument name="hasChildren" required="false" default="0" type="numeric" />

		<cfset setMenuItemUID(arguments.menuItemUID) />
		<cfset setMenuTitle(arguments.menuTitle) />
		<cfset setMenuAction(arguments.menuAction) />
		<cfset setMenuItemLevel(arguments.menuItemLevel) />
		<cfset setParentMenuItemUID(arguments.parentMenuItemUID) />
		<cfset setSort(arguments.sort) />
		<cfset setPageUID(arguments.pageUID) />
		<cfset setHasChildren(arguments.hasChildren) />

	</cffunction>

	<cffunction name="reset" access="public" output="false" returntype="void">
		<cfset setMenuItemUID("") />
		<cfset setMenuTitle("") />
		<cfset setMenuAction("") />
		<cfset setMenuItemLevel(0) />
		<cfset setParentMenuItemUID("") />
		<cfset setSort(0) />
		<cfset setPageUID("") />
		<cfset hasChildren(0) />
	</cffunction>

</cfcomponent>