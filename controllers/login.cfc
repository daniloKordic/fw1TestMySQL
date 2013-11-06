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

	<cffunction name="login" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true"/>

		<cfset var userValid = 0 />
		<cfset var userService = getUserService() />
		<cfset var user = ""/>

		<!--- if missing variables redirect to login form --->
		<cfif not structKeyExists(rc, "email") or not structKeyExists(rc, "password")>
			<cfset variables.fw.redirect("main") />
		</cfif>

		<!--- if all data ok, lookup user --->
		<cfset user = userService.getByEmail(rc.email) />

		<!--- if all good, check password --->
		<cfif len(user.getUID())>
			<cfset userValid = userService.validatePassword(user, rc.password) />
		</cfif>

		<cfif not userValid>
			<cfset rc.message = "Invalid Username or Password" />
			<cfset variables.fw.redirect("main","message") />
		<cfelse>
			<cfset rc.message = "Login Successfull!" />
		</cfif>

		<!--- since all ok, set sessoin variables --->
		<cfset session.auth.isLoggedIn = true />
		<cfset session.auth.fullName = user.getFirstName() & ' ' & user.getLastName() />
		<cfset session.auth.TypeID = user.GetTypeID() />
		<cfset session.auth.user = user />

		<cfset variables.fw.redirect("main", "message") />

	</cffunction>

	<cffunction name="logout" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="true" />

		<!--- reseting session variables --->
		<cfset session.auth.isLoggedIn = false />
		<cfset session.auth.fullName = "Guest" />
		<cfset session.auth.TypeID = 3 />
		<cfset structDelete(session.auth,"user") />
		<cfset rc.message = "You have safely logged out!" />
		<cfset variables.fw.redirect("main","message") />
	</cffunction>
	
</cfcomponent>