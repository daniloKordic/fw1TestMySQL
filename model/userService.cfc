<cfcomponent displayname="User Service" output="false">
	
	<cffunction name="init" output="false">
		<cfargument name="userGateway" required="true" type="component" />
		<cfset variables.instance.userGateway = arguments.userGateway />
		<cfreturn this />
	</cffunction>

	<cffunction name="getUserGateway" access="public" output="false">
		<cfreturn variables.instance.userGateway />
	</cffunction>

	<cffunction name="handleGrid" access="public" output="false" returntype="any">
		<cfargument name="url" required="false" type="any" />

		<cfscript>
			var grid = {
				pageNumber=1
				,rowsPerPage = 20
				,orderBy = "FirstName"
				,orderDirection = "asc"
				,start=0
			};
		</cfscript>

		<cfif structKeyExists(arguments.url, "pageNumber")><cfset grid.pageNumber = arguments.url.pageNumber /></cfif>
		<cfif structKeyExists(arguments.url, "rowsPerPage")><cfset grid.rowsPerPage = arguments.url.rowsPerPage /></cfif>
		<cfif structKeyExists(arguments.url, "orderBy")><cfset grid.orderBy = arguments.url.orderBy /></cfif>
		<cfif structKeyExists(arguments.url, "orderDirection")><cfset grid.orderDirection = arguments.url.orderDirection /></cfif>
		<cfif structKeyExists(arguments.url, "start")><cfset grid.start = arguments.url.start /></cfif>

		<cfreturn getUserGateway().getGrid(grid=grid) />
	</cffunction>

	<cffunction name="handleForm" access="public" output="false" returntype="Any">
		<cfargument name="form" type="any" required="true" />

		<cfscript>
			var user = createObject("component", "fw1Test.model.user").init();		
			var userUID="";
			var firstName="";
			var lastName="";
			var email="";
			var username="";
			var password="";
			var active=0;
			var userImage="";
			var address="";
			var timezone="";
		</cfscript>
		
		<cfif structKeyExists(arguments.form, "userUID")><cfset userUID=arguments.form.userUID /></cfif>
		<cfif structKeyExists(arguments.form, "firstName")><cfset firstName=arguments.form.firstName /></cfif>
		<cfif structKeyExists(arguments.form, "lastName")><cfset lastName=arguments.form.lastName /></cfif>
		<cfif structKeyExists(arguments.form, "email")><cfset email=arguments.form.email /></cfif>
		<cfif structKeyExists(arguments.form, "username")><cfset username=arguments.form.username /></cfif>
		<cfif structKeyExists(arguments.form, "password")><cfset password=arguments.form.password /></cfif>
		<cfif structKeyExists(arguments.form, "active")><cfset active=arguments.form.active /></cfif>
		<cfif structKeyExists(arguments.form, "userImage")><cfset userImage=arguments.form.userImage /></cfif>
		<cfif structKeyExists(arguments.form, "address")><cfset address=arguments.form.address /></cfif>
		<cfif structKeyExists(arguments.form, "Timezonee")><cfset timezone=arguments.form.Timezonee /></cfif>

		<cfset user.setupUser (
			UID=userUID
			,FirstName=firstName
			,LastName=lastName
			,Email=email
			,Username=username
			,Password=password
			,IsActive=active
			,UserImage=userImage
			,Address=address
			,Timezone=timezone
		) />

		<cfif structKeyExists(arguments.form, "fsw")>
			<cfswitch expression="#arguments.form.fsw#">
				<cfcase value="save">
					
					<cfset filter = {
						email = user.getEmail()
					} />
					
					<cfset var qHowMany = getUserGateway().getByFilter(filter=filter) />
					
					<cfif qHowMany.recordCount eq 0>
						
						<cfset var newUserUID = getUserGateway().save(user=user) />						
						
						<cfset result.message="User Successfully saved!"/>
						<cfset result.userUID=newUserUID />						
					<cfelse>
						<cfset result.message = "Duplicate User Found!"/>
						<cfset user.reset() />
					</cfif>					
				</cfcase>
				<cfcase value="update">
					<cfset var rezultat = getUserGateway().save(user = user) />
					<cfif rezultat neq "">
						<cfset result.message = "User successfully updated!" />
					</cfif>
				</cfcase>
				<cfcase value="delete">
					<cfset var rezultat = getUserGateway().delete(user = user) />
					<cfif rezultat eq 1>
						<cfset result.message = "User successfully deleted!" />
					</cfif>
				</cfcase>
			</cfswitch>
		</cfif>

		<cfset var event = {
			user = user
			,result = result
		} />
		

		<cfreturn event />
	</cffunction>

	<cffunction name="handleRequest" access="public" output="false" returntype="any">
		<cfargument name="url" type="any" required="true" />

		<cfscript>
			var uid = "";
			var result = {
			 	errorFields=""
			 	,message=""
			};
		</cfscript>

		<cfif structKeyExists(arguments.url, "uid")><cfset uid=arguments.url.uid /></cfif>

		<cfset var user = getUserGateway().getByKey(uid=uid) />
		
		<cfset var event = {user=user, result=result} />

		<cfreturn event />
	</cffunction>

	<cffunction name="getByEmail" access="public" output="false" returntype="any">
		<cfargument name="email" required="true" type="string" default="" />

		<cfset var result = "" />
		<cfset var user = "" />

		<cfif len(arguments.email)>
			<cfset result = getUserGateway().getByEmail(email=arguments.email) />	
		</cfif>

		<cfif not isStruct(result)>
			<cfset result = createObject("component", "fw1Test.model.user").init() />
		</cfif>

		<cfreturn result />
	</cffunction>

	<cffunction name="validatePassword" access="public" output="false" returntype="boolean">
		<cfargument name="user" required="false" type="any" />
		<cfargument name="password" required="false" type="string" />

		<cfset var validPass = false />

		<cfif arguments.password eq arguments.user.getPassword()>
			<cfset var validPass = true />
		</cfif>

		<cfreturn validPass />
	</cffunction>

	<cffunction name="confirmUser" access="public" output="false" returntype="string">
		<cfargument name="userUID" required="false" type="string" default="" />

		<cfset var result = "Invalid User!" />

		<cfif arguments.userUID neq "">			
			<cfset var result = getUserGateway().confirmAccount(userUID=arguments.userUID) />
		</cfif>

		<cfreturn result />
	</cffunction>

	<cffunction name="UploadFileCall" access="remote" output="false" returnformat="JSON">
		<!--- <cfargument name="name" type="string">
		<cfargument name="format" type="string" default="0">
		<cfargument name="description" type="string" default="">
		<cfargument name="file" type="string">
		<cfargument name="PCVersionUID" type="string"> 
		<cfargument name="GraphicsType" type="string">
		<cfargument name="IsMainImage" type="numeric" default="0">
		<cfargument name="Sector" type="string" default="8">

		<cfset var fMaintenanceLogUID=''/>

		<cfif structKeyExists(arguments,"PCVersionUID") and len(arguments.PCVersionUID)>
			<cfset fMaintenanceLogUID=arguments.PCVersionUID />
			<cfset var pcmaintenance=variables.pcmaintenanceGateway.getByKey(MaintenanceLogUID=fMaintenanceLogUID) />
		</cfif>
 
		<cfset var uploadDir="#application.TempImagesDir#">

		<cfif not directoryExists(uploadDir)>
    		<cfdirectory action="create" directory="#application.TempImagesDir#">
		</cfif> --->


	<!--- Chunks mambodzambo --->
	    <!--- <cfscript>
	      var uploadFile =  uploadDir & arguments.NAME;
	      var response = {'result' = arguments.NAME, 'id' = 0};
	      var result = {};
	      // if chunked append chunk number to filename for reassembly
	      if (structKeyExists(arguments, 'CHUNKS')){
	        uploadFile = uploadFile & '.' & arguments.CHUNK;
	        response.id = arguments.CHUNK;
	      }
	    </cfscript>		
			
	    <!--- save file data from multi-part form.FILE --->
	    <cffile action="upload" result="fileResult" filefield="file" destination="#uploadFile#" nameconflict="overwrite"/>
			
	    <cfscript>
	       
	      response['size'] = fileResult.fileSize;
	      response['type'] = fileResult.contentType;
	      response['saved'] = fileResult.fileWasSaved;
	      response['completed'] = (!structKeyExists(arguments, 'CHUNKS')) and fileResult.fileWasSaved;
				
	      // reassemble chunked file
	      if (structKeyExists(arguments, 'CHUNKS') && arguments.CHUNK + 1 == arguments.CHUNKS){
	      	try {
	          var uploadFile = uploadDir & arguments.NAME; // file name for reassembled file 
	          if (fileExists(uploadFile)){
	            fileDelete(uploadFile); // delete otherwise append will add chunks to an existing file
	          }
	
	          var tempFile = fileOpen(uploadFile,'append');
	          for (var i = 0; i < arguments.CHUNKS; i++) {
	            var chunk = fileReadBinary('#uploadDir#/#arguments.NAME#.#i#');
	            fileDelete('#uploadDir#/#arguments.NAME#.#i#');
	            fileWrite(tempFile, chunk);
	          }
	          fileClose(tempFile);
	          response['completed']=true;
	          
				}
	      	catch(any err){
	          // clean up chunks for incomplete upload
	          var d = directoryList(uploadDir,false,'name');
	          if (arrayLen(d) != 0){
	            for (var i = 1; i <= arrayLen(d); i++){
	              if (listFirst(d[i]) == arguments.NAME && val(listLast(d[i])) != 0){
	                fileDelete('#uploadDir##d[i]#');
	              }
	            }
	          }
	 
	          response = {'error' = {'code' = 500, 'message' = 'Internal Server Error, chunks'}, 'id' = 0, 'completed'=false}; 
	          return response; 
	        }
	      }
	      
	    </cfscript>
		<!--- End of chunks --->
		<cfif  (!response['completed'])>
			<cfreturn response>
		</cfif>
		
		<cfset var dest="#application.ImagesDir#">
		<cfset var relDest="../Images/">
		
	
		<cfset var savedFileUID =  insert("-", CreateUUID(), 23)  /><!--- Stupid cf uid is not compatibile with MSSQL uid --->

		<cfif not directoryExists(dest)><cfdirectory action="create" directory="#dest#"></cfif>
		
		<cffile 
		    action = "move" 
		    source = "#uploadFile#" 
		    destination = "#dest##arguments.NAME#"> --->
		
		
		<cfargument name="name" type="string">
		<cfargument name="format" type="string" default="0">
		<cfargument name="description" type="string" default="">
		<cfargument name="file" type="string">
		<cfargument name="PCVersionUID" type="string"> 
		<cfargument name="GraphicsType" type="string">
		<cfargument name="IsMainImage" type="numeric" default="0">
		<cfargument name="Sector" type="string" default="8">

		
		<cfset var uploadDir="#application.TempImagesDir#">

		<cfif not directoryExists(uploadDir)>
    		<cfdirectory action="create" directory="#application.TempImagesDir#">
		</cfif>


		<!--- Chunks mambodzambo --->
	    <cfscript>
	      var uploadFile =  uploadDir & arguments.NAME;	      
	      var response = {'result' = arguments.NAME, 'id' = 0};
	      var result = {};
	      // if chunked append chunk number to filename for reassembly
	      if (structKeyExists(arguments, 'CHUNKS')){
	        uploadFile = uploadFile & '.' & arguments.CHUNK;
	        response.id = arguments.CHUNK;
	      }
	    </cfscript>		
		
	    <!--- save file data from multi-part form.FILE --->
	    <cffile action="upload" result="fileResult" filefield="file" destination="#uploadFile#" nameconflict="makeUnique"/>
			
		
	    <!---<cfscript>
	       
	      response['size'] = fileResult.fileSize;
	      response['type'] = fileResult.contentType;
	      response['saved'] = fileResult.fileWasSaved;
	      response['completed'] = (!structKeyExists(arguments, 'CHUNKS')) and fileResult.fileWasSaved;
				
	      // reassemble chunked file
	      if (structKeyExists(arguments, 'CHUNKS') && arguments.CHUNK + 1 == arguments.CHUNKS){
	      	try {
	          var uploadFile = uploadDir & arguments.NAME; // file name for reassembled file 
	          if (fileExists(uploadFile)){
	            fileDelete(uploadFile); // delete otherwise append will add chunks to an existing file
	          }
	
	          var tempFile = fileOpen(uploadFile,'append');
	          for (var i = 0; i < arguments.CHUNKS; i++) {
	            var chunk = fileReadBinary('#uploadDir#/#arguments.NAME#.#i#');
	            fileDelete('#uploadDir#/#arguments.NAME#.#i#');
	            fileWrite(tempFile, chunk);
	          }
	          fileClose(tempFile);
	          response['completed']=true;
	          
				}
	      	catch(any err){
	          // clean up chunks for incomplete upload
	          var d = directoryList(uploadDir,false,'name');
	          if (arrayLen(d) != 0){
	            for (var i = 1; i <= arrayLen(d); i++){
	              if (listFirst(d[i]) == arguments.NAME && val(listLast(d[i])) != 0){
	                fileDelete('#uploadDir##d[i]#');
	              }
	            }
	          }
	 
	          response = {'error' = {'code' = 500, 'message' = 'Internal Server Error, chunks'}, 'id' = 0, 'completed'=false}; 
	          return response; 
	        }
	      }
	      
	    </cfscript>--->
		<!--- End of chunks --->
		<!---<cfif  (!response['completed'])>
			<cfreturn response>
		</cfif>--->
		
		<cfset var dest="#application.ImagesDir#">
		<cfset var relDest="../Images/">
		
	
		<cfset var savedFileUID =  insert("-", CreateUUID(), 23)  /><!--- Stupid cf uid is not compatibile with MSSQL uid --->

		<cfif not directoryExists(dest)><cfdirectory action="create" directory="#dest#"></cfif>
		
		<!--- <cffile 
		    action = "move" 
		    source = "#uploadFile#" 
		    destination = "#dest#original\#arguments.NAME#"> --->

		<!--- <cffile action="delete" source="" /> --->

		<!--- <cffile 
		    action = "copy" 
		    source = "#dest#original\#arguments.NAME#" 
		    destination = "#dest##arguments.NAME#">

		<cfimage source="#dest##arguments.NAME#" name="myImage">
		<cfset ImageScaleToFit(myImage,200,"","highestPerformance")>

		<cfimage 
		    action = "write" 
		    destination = "#dest##arguments.NAME#" 
		    source = "#myImage#" 
		    overwrite = "yes" 
		    quality = "1"> --->
		

	</cffunction>

	<cffunction name="getFile" access="remote" output="false" returnformat="plain">
		<cfargument name="target" type="string" required="true" default="" />

		<cfset var FileArr = getUserGateway().qSelect() />
		<!--- TODO: check if empty result set --->
		<cfset StructAppend(FileArr, {TARGETDIV="#arguments.target#"}, true) >
<!--- 
		<cfset var saveDir= saveDirQ.ROWS[1].TITLE>
		<cfset var GraphicsTypeId= saveDirQ.ROWS[1].ID>
 --->			

		 <!--- <cf_ftdebugger file="c:/temp/somefile.txt" output="#SerializeJSON(FileArr)#">  ---> 

		<cfreturn  FileArr />
	</cffunction>

</cfcomponent>