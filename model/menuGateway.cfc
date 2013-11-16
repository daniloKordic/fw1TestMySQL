<cfcomponent>
	
	<cfset variables.instance = {} />

	<cffunction name="init" output="false">
		<cfargument name="settings" required="true" type="any" />

		<cfset variables.instance.config = arguments.settings.getConfig() />
		<cfset variables.instance.dsn = variables.instance.config.dsn />

		<cfreturn this />
	</cffunction>

	<cffunction name="getDSN" access="private" output="false" returntype="String">
		<cfreturn variables.instance.dsn />
	</cffunction>

	<!--- CREATE --->
	<cffunction name="create" access="public" output="false" returntype="string">
		<cfargument name="menuItem" required="true" type="any" />
		<cfset var qry="" />
		<cfset var fSort =  arguments.menuItem.getSort()/>

		<cfquery name="qry" datasource="#getDSN()#">
			select  uuid() as newUID
		</cfquery>
		<cfset var uid = qry.newUID />

		<cfquery name="getSort" datasource="#getDSN()#">
			select
				MAX(coalesce(sort,0))+1 as sort
			from 
				Menu
			where
				1=1
				<cfif arguments.menuItem.getParentMenuItemUID() neq "">
					and ParentMenuItemUID='#arguments.menuItem.getParentMenuItemUID()#' 
				<cfelse>
					and MenuItemLevel = 1
				</cfif>			
				and menuItemUID != '3981D4BE-1A4E-4899-A919-ACB01383B8BA'	
		</cfquery>
		
		<cfif getSort.sort neq "">
			<cfset fSort = #getSort.sort# />	
		</cfif>		
		
		
		<cfquery name="qry" datasource="#getDSN()#">
			insert into Menu (
				MenuItemUID
				,MenuTitle
				,MenuItemLevel
				,ParentMenuItemUID
				,Sort
				,PageUID
				,action
			) values (
				 <cfqueryparam cfsqltype="cf_sql_varchar" value="#uid#" />
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.menuItem.getMenuTitle()#" />
				,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.menuItem.getMenuItemLevel()#" />
				<cfif arguments.menuItem.getParentMenuItemUID() neq "">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.menuItem.getParentMenuItemUID()#" />
				<cfelse>
					,NULL
				</cfif>				
				,#fSort#
				<cfif arguments.menuItem.getPageUID() neq "">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.menuItem.getPageUID()#" />
				<cfelse>
					,NULL	
				</cfif>
				<cfif arguments.menuItem.getMenuAction() neq "">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.menuItem.getMenuAction()#" />
				<cfelse>
					,NULL	
				</cfif>
			)
		</cfquery>

		<cfreturn uid />
	</cffunction>

	<!--- UPDATE --->
	<cffunction name="update" access="public" output="false" returntype="String">
		<cfargument name="menuItem" required="true" type="any" />
		<cfset var qry = ""/>
		<cfset var uid = arguments.menuItem.getMenuItemUID() />
		<cfquery name="qry" datasource="#getDSN()#">
			update Menu set
				 MenuTitle=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.menuItem.getMenuTitle()#" />				 
				,MenuItemLevel=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.menuItem.getMenuItemLevel()#" />
				<cfif arguments.menuItem.getParentMenuItemUID() neq "">
					,ParentMenuItemUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.menuItem.getParentMenuItemUID()#" />
				<cfelse>
					,ParentMenuItemUID=NULL	
				</cfif>				
				,Sort=<cfqueryparam value="#arguments.menuItem.getSort()#" cfsqltype="cf_sql_integer" />
				<cfif arguments.menuItem.getMenuAction() neq "">
					,action=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.menuItem.getMenuAction()#" />
				<cfelse>
					,action=NULL	
				</cfif>		
			where
				MenuItemUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.menuItem.getMenuItemUID()#" />
		</cfquery>

		<cfreturn uid />
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="string">
		<cfargument name="menuItem" required="true" type="any" />
		<cfset var uid = "" />

		<cfif len(arguments.menuItem.getMenuItemUID())>
			<cfset var uid = update(menuItem = arguments.menuItem) />
		<cfelse>
			<cfset var uid = create (menuItem = arguments.menuItem) />
		</cfif>

		<cfreturn  uid />
	</cffunction>

	<!--- DELETE --->
	<cffunction name="delete" access="public" output="false" returntype="Numeric">
		<cfargument name="menuItem" required="true" type="any" />
		<cfset var qry = ""/>

		<cfquery name="qry" datasource="#getDSN()#">
			delete from Menu where MenuItemUID=<cfqueryparam value="#arguments.menuItem.getMenuItemUID()#" cfsqltype="cf_sql_varchar" />
		</cfquery>

		<cfreturn 1 />
	</cffunction>

	<cffunction name="getAll" access="public" output="false" returntype="Query">
		<cfset qryMenu = ""/>

		<cfquery name="qryMenu" datasource="#getDSN()#">
			select
				m.MenuItemUID,
				m.MenuTitle as MenuTitle,
				coalesce(m.PageUID,null) as PageUID,
				m.MenuItemLevel,
				coalesce(m.ParentMenuItemUID,null) as ParentMenuItemUID,				
				(select MenuTitle from Menu mm where mm.MenuItemUID=m.ParentMenuItemUID) as ParentMenuItem,
				Sort,
				(select count(MenuItemUID) from Menu where ParentMenuItemUID=m.MenuItemUID) as isParent,
				m.Action
			from
				Menu m
			where
				1=1
			order
				by m.menuItemLevel, m.Sort
		</cfquery>

		<cfreturn qryMenu />
	</cffunction>

	<cffunction name="getByKey" access="public" output="false" returntype="struct">
		<cfargument name="uid" required="false" type="String" default="" />

		<cfset var qry="" />
		<cfset var menuItem = createObject("component","fw1Test.model.menu").init() />

		<cfif arguments.uid neq "">
			<cfquery name="qry" datasource="#getDSN()#">
				select
					m.MenuItemUID
					,m.MenuTitle
					,m.MenuItemLevel
					,m.ParentMenuItemUID
					,m.Sort
					,m.PageUID
					,m.action
					,case when (select count(me.menuTitle) from Menu me where me.MenuItemUID=m.MenuItemUID) then 1 else 0 end as hasChildren
				from
					Menu m  
				where
					1=1
					and m.MenuItemUID='#arguments.uid#'
			</cfquery>

			<cfif qry.recordCount eq 1>
				<cfset menuItem.setupMenuItem (
					 menuItemUID=qry.MenuItemUID
					,menuTitle=qry.MenuTitle
					,menuItemLevel=qry.MenuItemLevel
					,parentMenuItemUID=qry.ParentMenuItemUID
					,sort=qry.Sort 
					,pageUID=qry.PageUID
					,menuAction=qry.action
					,hasChildren=qry.hasChildren
				) />
			</cfif>
		</cfif>		

		<cfreturn menuItem />
	</cffunction>

	<cffunction name="getByFilter" access="public" output="false" returntype="query">
		<cfargument name="filter" required="false" type="struct" default="#structNew()#" />
		<cfset var qry=""/>

		<cfquery name="qry" datasource="#getDSN()#">
			select
				m.*
			from
				Menu m 
			where
				1=1
				<cfif structKeyExists(arguments.filter, "menuTitle") and len(arguments.filter.menuTitle)>
					and m.MenuTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.menuTitle#" />
				</cfif>
		</cfquery>

		<cfreturn qry />
	</cffunction>

	<cffunction name="getParents" access="public" output="false" returntype="query">
		<cfset var qry=""/>

		<cfquery name="qry" datasource="#getDSN()#">
			select 
				m.* 
			from
				Menu m 
			where 
				1=1
				and m.MenuItemLevel < 3
			order by
				m.MenuItemLevel, m.sort
		</cfquery>

		<cfreturn qry />
	</cffunction>

	<cffunction name="getParentItemLevel" access="public" output="false" returntype="Numeric">
		<cfargument name="parentMenuItemUID" required="true" type="string" default="" />
		<cfset var qry = ""/>

		<cfquery name="qry" datasource="#getDSN()#">
			select
				coalesce(m.MenuItemLevel,0)+1 as menuItemLevel
			from
				Menu m  
			where
				m.MenuItemUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.parentMenuItemUID#" />
		</cfquery>

		<cfreturn qry.menuItemLevel />
	</cffunction>

	<cffunction name="checkDelete" access="public" output="false" returntype="Numeric">
		<cfargument name="menuItem" required="true" type="any" />
		<cfset var qry="" />

		<cfquery name="qry" datasource="#getDSN()#">
			select count(MenuTitle) as hasChildren from Menu where ParentMenuItemUID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.menuItem.getMenuItemUID()#" />
		</cfquery>

		<cfreturn qry.hasChildren />
	</cffunction>

</cfcomponent>