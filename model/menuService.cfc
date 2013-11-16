<cfcomponent>
	
	<cffunction name="init" output="false">
		<cfargument name="menuGateway" required="true" type="component" />
		<cfset variables.instance.menuGateway = arguments.menuGateway />
		<cfreturn this />
	</cffunction>

	<cffunction name="getMenuGateway" access="public" output="false">
		<cfreturn variables.instance.menuGateway />
	</cffunction>

	<cffunction name="getMenu" access="public" output="false" returntype="Query">
		<cfreturn getMenuGateway().getAll() />
	</cffunction>

	<cffunction name="HandleRequest" access="public" output="false" returntype="any">
		<cfargument name="url" type="any" required="true" default="" />

		<cfscript>
			var uid = "";
			var result = {
				errorFields=""
				,message=""
			};	
		</cfscript>

		<cfif structKeyExists(arguments.url, "uid")><cfset uid = arguments.url.uid /></cfif>

		<cfset var menuItem = getMenuGateway().getByKey(uid=uid) />
		<cfset var parents = getMenuGateway().getParents() />
		<cfset var event = { menuItem = menuItem, parents = parents, result=result } />

		<cfreturn event />		
	</cffunction>

	<cffunction name="HandleForm" access="public" output="false" returntype="any">
		<cfargument name="form" type="any" required="true" default="" />

		<cfscript>
			var menuItem = createObject("component","fw1Test.model.menu").init();
			var menuItemUID="";
			var menuTitle="";
			var menuAction="";
			var menuItemLevel=1;
			var parentMenuItemUID="";
			var sort=1;
			var pageUID="";
			var hasChildren=0;			
		</cfscript>

		<cfif structKeyExists(arguments.form, "menuItemUID")><cfset menuItemUID=arguments.form.menuItemUID /></cfif>
		<cfif structKeyExists(arguments.form, "menuTitle")><cfset menuTitle=arguments.form.menuTitle /></cfif>
		<cfif structKeyExists(arguments.form, "menuAction")><cfset menuAction=arguments.form.menuAction /></cfif>
		<cfif structKeyExists(arguments.form, "menuItemLevel")><cfset menuItemLevel=arguments.form.menuItemLevel /></cfif>
		<cfif structKeyExists(arguments.form, "parentMenuItemUID")><cfset parentMenuItemUID=arguments.form.parentMenuItemUID /></cfif>
		<cfif structKeyExists(arguments.form, "sort")><cfset sort=arguments.form.sort /></cfif>
		<cfif structKeyExists(arguments.form, "pageUID")><cfset pageUID=arguments.form.pageUID /></cfif>
		<cfif structKeyExists(arguments.form, "hasChildren")><cfset hasChildren=arguments.form.hasChildren /></cfif>

		<cfif parentMenuItemUID neq "">
			<cfset menuItemLevel = getMenuGateway().getParentItemLevel(parentMenuItemUID = parentMenuItemUID) />
		</cfif>

		<cfset menuItem.setupMenuItem(
			 menuItemUID=menuItemUID
			,menuTitle=menuTitle
			,menuAction=menuAction
			,menuItemLevel=menuItemLevel
			,parentMenuItemUID=parentMenuItemUID
			,sort=sort
			,pageUID=pageUID
			,hasChildren=hasChildren
		) />

		<cfif structKeyExists(form, "fsw")>
			<cfswitch expression="#arguments.form.fsw#">
				<cfcase value="save">
					
					<cfset filter = {
						menuTitle = menuItem.getMenuTitle()
					} />

					<cfset qHowMany = getMenuGateway().getByFilter(filter = filter) />

					<cfif qHowMany.recordCount eq 0>
						<cfset var newMenuItemUID = getMenuGateway().save(menuItem = menuItem) />
						<cfset result.message = "Menu Item successfully saved!" />
					<cfelse>
						<cfset menuItem.reset() />
						<cfset result.message = "Duplicate Menu Item found!" />
					</cfif>
				</cfcase>
				<cfcase value="update">
					<cfset var rezultat = getMenuGateway().save(menuItem = menuItem) />
					<cfset result.message="Menu Item successfully updated!" />
				</cfcase>
				<cfcase value="delete">
					<cfset dozvola = getMenuGateway().checkDelete(menuItem = menuItem) />
					<cfif dozvola eq 0>
						<cfset rezultat = getMenuGateway().delete(menuItem = menuItem) />
						<cfif rezultat eq 1>
							<cfset result.message="Menu Item successfully deleted!" />
						</cfif>
					<cfelse>	
						<cfset result.message="Menu Item has children and cannot be deleted!" />
					</cfif>
					
				</cfcase>
			</cfswitch>
		</cfif>

		<cfset var event = {
			menuItem = menuItem
			,result = result
			,parents = getMenuGateway().getParents()
		} />

		<cfreturn event />
	</cffunction>

</cfcomponent>