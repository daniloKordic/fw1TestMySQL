<cfcomponent>
	

	<cfset variables.fw = "" />

	<cffunction name="init">
		<cfargument name="fw" />

		<cfset variables.fw = arguments.fw />
	</cffunction>

	<cffunction name="setUserService" access="public" output="false" returntype="void">
		<cfargument name="userService" type="any" required="true" />
		<cfset variables.userService = arguments.userService />
	</cffunction>
	<cffunction name="getUserService" access="public" output="false" returntype="any">
		<cfreturn variables.userService />
	</cffunction>

	<cffunction name="before" access="public" returntype="void">
		<cfset setUserService(application.beanFactory.GetBean('userService')) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void">
		<cfset var userService = getUserService() />
		<cfset rc.qGrid = userService.handleGrid(url) />
	</cffunction>

	<cffunction name="manage" access="public" returntype="void">
		
		<cfset var userService = getUserService() />

		<cfif structKeyExists(rc, "fsw") and Len(rc.fsw)>
			<cfset var rc.event = userService.handleForm(form) />
		<cfelse>
			<cfset var rc.event = userService.handleRequest(url) />
		</cfif>

		<cfif structKeyExists(rc, "fsw") and (rc.fsw eq "save" 	or rc.fsw eq "delete" or rc.fsw eq "update")>
			<cfset variables.fw.redirect("users","event") />
		</cfif>
	</cffunction>

	<cffunction name="confirm" access="public" returntype="void">
		
		<cfset var userService = getUserService() />

		<cfif structKeyExists(url, "userUID") and Len(url.userUID)>
			<cfset var userUID = "#url.userUID#" />
			<cfset var rc.event.result = userService.confirmUser(userUID=userUID) />	
		<cfelse>
			<cfset var rc.event.result = "Invalid User!" />
		</cfif>
		
	</cffunction>

	<cffunction name="image" access="public" returntype="any">
		<cfset var userService = getUserService() />
		
				
	</cffunction>

</cfcomponent>