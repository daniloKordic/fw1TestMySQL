<cfcomponent>
	
	<cffunction name="init" output="false">
		<cfargument name="productGateway" required="true" type="component" />
		<cfset variables.instance.productGateway = arguments.productGateway />
		<cfreturn this />
	</cffunction>

	<cffunction name="getProductGateway" access="private" output="false">
		<cfreturn variables.instance.productGateway />
	</cffunction>

	<cffunction name="handleGrid" access="public" output="false" returntype="any">
		<cfargument name="url" type="any" required="true" />

		<cfscript>
			var grid = {
				pageNumber=1
				,rowsPerPage = 20
				,orderBy = "updated"
				,orderDirection = "desc"
				,start=0
			};
		</cfscript>

		<cfif structKeyExists(arguments.url, "pageNumber")><cfset grid.pageNumber = arguments.url.pageNumber /></cfif>
		<cfif structKeyExists(arguments.url, "rowsPerPage")><cfset grid.rowsPerPage = arguments.url.rowsPerPage /></cfif>
		<cfif structKeyExists(arguments.url, "orderBy")><cfset grid.orderBy = arguments.url.orderBy /></cfif>
		<cfif structKeyExists(arguments.url, "orderDirection")><cfset grid.orderDirection = arguments.url.orderDirection /></cfif>
		<cfif structKeyExists(arguments.url, "start")><cfset grid.start = arguments.url.start /></cfif>

		<cfreturn getProductGateway().getGrid(grid=grid) />
	</cffunction>

	<cffunction name="HandleRequest" access="public" output="false" returntype="any">
		<cfargument name="url" type="any" required="true" />

		<cfscript>
			var uid = "";
			var result = {
			 	errorFields=""
			 	,message=""
			};
		</cfscript>

		<cfif structKeyExists(arguments.url, "uid")><cfset uid=arguments.url.uid /></cfif>

		<cfset var product = getProductGateway().getByKey(uid=uid) />
		<cfset var categories = getProductGateway().getCategories() />
		<cfset var event = {product=product, categories=categories, result=result} />

		<cfreturn event />
	</cffunction>

	<cffunction name="HandleForm" access="public" output="false" returntype="any">
		<cfargument name="form" type="any" required="true" />

		<cfscript>
			var product = createObject("component","fw1Test.model.product").init();
			var productUID = "";
			var productName = "";
			var productDescription = "";
			var isActive = 0;
			var numProductPhotos = 0;
			var categoryUID = "";
			var productPhotos = "";			
		</cfscript>

		<cfif structKeyExists(arguments.form, "productUID")><cfset productUID=arguments.form.productUID /></cfif>
		<cfif structKeyExists(arguments.form, "productName")><cfset productName=arguments.form.productName /></cfif>
		<cfif structKeyExists(arguments.form, "productDescription")><cfset productDescription=arguments.form.productDescription /></cfif>
		<cfif structKeyExists(arguments.form, "active")><cfset isActive=arguments.form.active /></cfif>
		<cfif structKeyExists(arguments.form, "numProductPhotos")><cfset numProductPhotos=arguments.form.numProductPhotos /></cfif>
		<cfif structKeyExists(arguments.form, "categoryUID")><cfset categoryUID=arguments.form.categoryUID /></cfif>
		<cfif structKeyExists(arguments.form, "productImage")><cfset productPhotos=arguments.form.productImage /></cfif>

		<cfset product.setupProduct (
			productUID=productUID
			,productName=productName
			,productDescription=productDescription
			,categoryUID=categoryUID
			,active=isActive
			,numProductPhotos=numProductPhotos
			,productPhotos=productPhotos
		) />
		
		<cfif structKeyExists(arguments.form, "fsw")>
			<cfswitch expression="#arguments.form.fsw#">
				<cfcase value="save">
					<cfset filter = {
						productName = product.getProductName()
					} />

					<cfset var qHowMany = getProductGateway().getByFilter(filter=filter) />

					<cfif qHowMany.recordcount eq 0>
						<cfset var newProductUID=getProductGateway().save(product=product) />
						<cfset result.message="Product successfully saved!" />
					<cfelse>
						<cfset result.message="Duplicate Product Name found!" />
						<cfset product.reset() />
					</cfif>
				</cfcase>
				<cfcase value="update">
					<cfset rezultat = getProductGateway().save(product = product) />
					<cfif rezultat neq "">
						<cfset result.message = "Product successfully updated!"/>
					</cfif>					
				</cfcase>
				<cfcase value="delete">
					<cfset rezultat = getProductGateway().delete(product = product) />
					<cfif rezultat eq 1>
						<cfset result.message = "Product successfully deleted!"/>
					</cfif>					
				</cfcase>
			</cfswitch>
		</cfif>
		
		<cfset var event = {
			product = product
			,result = result
		} />

		<cfreturn event />
	</cffunction>

	<cffunction name="getProducts" access="public" output="false" returntype="any">
		<cfargument name="uid" default="" type="string" required="false" />
		<cfargument name="count" type="numeric" required="false" default="0" />
		<cfset var products = ""/>

		<cfif arguments.uid neq "">
			<cfset products = getProductGateway().getByUID(uid=arguments.uid) />
		<cfelse>	
			<cfset products = getProductGateway().getProducts(count=arguments.count) />
		</cfif>

		<cfreturn products />
	</cffunction>

	<cffunction name="getProductsByCategory" access="public" output="false" returntype="any">
		<cfargument name="cuid" required="false" type="string" default="" />
		<cfset var products=""/>

		<cfif arguments.cuid neq "">
			<cfset products = getProductGateway().getByCategory(cuid=arguments.cuid) />
		</cfif>

		<cfreturn products />
	</cffunction>

	<cffunction name="UploadFileCall" access="remote" output="false" returnformat="JSON">
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
		    destination = "#dest#original\#arguments.NAME#">

		<!--- <cffile action="delete" source="" /> --->

		<cffile 
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
		    quality = "1">
		 		 		
	</cffunction>
</cfcomponent>