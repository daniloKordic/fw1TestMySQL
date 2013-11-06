<cfcomponent>
	<cffunction name="init" access="public" output="false">
		<cfset variables.config = structNew() />
		<cfreturn this />
	</cffunction>

	<cffunction name="SetConfig" access="public" returntype="void" output="false">
		<cfargument name="value" type="struct"/>
		<cfset var i = ""/>
		<cfset variables.config = arguments.value />

		<cfloop collection="#arguments.value#" item="i">
			<cfif not structKeyExists(this, i)>
				<cfset this[i] = arguments.value[i] />
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="GetConfig" access="public" returntype="Struct" output="false">
		<cfreturn duplicate(variables.config) />
	</cffunction>

	<cffunction name="GetConfigSettings" access="public" returntype="any" output="false">
		<cfargument name="name" required="true" type="string">
		<cfreturn variables.config[arguments.name] />
	</cffunction>
	
</cfcomponent>