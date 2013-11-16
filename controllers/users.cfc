<cfcomponent>
	

	<cfset variables.fw = ""/>
	<cffunction name="init" access="public" returntype="void">
		<cfargument name="fw" type="any" required="true"/>
		<cfset variables.fw = arguments.fw />
	</cffunction>

	<cffunction name="setUserService" access="public" output="false" returntype="void">
		<cfargument name="userService" type="any" required="true"/>
		<cfset variables.userService=arguments.userService/>
	</cffunction>
	<cffunction name="getUserService" access="public" output="false" returntype="any">
		<cfreturn variables.userService />
	</cffunction>

	<cffunction name="before" access="public" output="false" returntype="void">
		<cfargument name="rc" type="struct" required="true" />
		<cfset setUserService(application.beanFactory.GetBean('userService')) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<cfset var userService = getUserService() />
		<cfset arguments.rc.qGrid = userService.handleGrid(url) />
	</cffunction>

	<cffunction name="manage" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<cfset var userService = getUserService() />

		<cfif structKeyExists(arguments.rc, "fsw") and Len(arguments.rc.fsw)>
			<cfset arguments.rc.event = userService.handleForm(form) />
		<cfelse>
			<cfset arguments.rc.event = userService.handleRequest(url) />
		</cfif>
			<cfdump var="#arguments.rc.event.user.getUsername()#" output="C:\rtt.txt" />
		<cfif structKeyExists(arguments.rc, "fsw") and (arguments.rc.fsw eq "save" 	or arguments.rc.fsw eq "delete" or arguments.rc.fsw eq "update")>
			<cfset variables.fw.redirect("users","event") />
		</cfif>
	</cffunction>

	<cffunction name="confirm" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<cfset var userService = getUserService() />

		<cfif structKeyExists(url, "userUID") and Len(url.userUID)>
			<cfset var userUID = "#url.userUID#" />
			<cfset arguments.rc.event.result = userService.confirmUser(userUID=userUID) />	
		<cfelse>
			<cfset arguments.rc.event.result = "Invalid User!" />
		</cfif>
		
	</cffunction>

	<cffunction name="image" access="public" returntype="any">
		<cfset var userService = getUserService() />
		
				
	</cffunction>

</cfcomponent>