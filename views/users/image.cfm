

<cfset fSOIVersionUID="" />
<cfset fPCVersionUID="" />
<cfset GraphicsType=""/>


<cfoutput>

<script type="text/javascript" src="assets/js/plupload/plupload.js"></script>
<script type="text/javascript" src="assets/js/plupload/plupload.html5.js"></script>
<script>
	//Progressbar
  $(function() {
	var progressbar = $( "##progressbar" );
  	var progressLabel = $( ".progress-label" );
 
    progressbar.progressbar({
      value: false,
      change: function() {
        progressLabel.text( progressbar.progressbar( "value" ) + "%" );
      },
      complete: function() {
        progressLabel.text( "Complete!" );
      }
    });
    progressbar.progressbar( "value", 0 );

  });
	
</script>

<style>
  .progress-label {
   float: left;
   /*margin-left: 25%;*/
	width:300px; 
	text-align:center;
	margin-left: auto;
 	margin-right: auto;
    margin-top: 1px;
    font-weight: bold;
    text-shadow: 1px 1px 0 ##fff;
  }
  .row{
  	margin-top:20px;
  	padding: 0 !important;
  	border:none;
  }
  .container-long{
  	width:auto !important;
  }
</style>

<div id="container" style="min-height:100%; height:800px;">
	<input type="hidden" id="file" name="file" value="" /> 
	<div class="row-head width-800px float-left">
		<div class="tabtitle width-100 margin-top-0 margin-bottom-10">
			Drag &amp; drop your files here
		</div>
	<div class="clear"></div>
	<div class="inlineStrip margin-top-10 margin-left-15 margin-right-15 height-50px textCenter"><span class="bold">You can drag selected files and drop them anywhere on this page</span></div>
	<div class="backgrey-100 nobackground margin-bottom-10">
		
			<table class="table" id ="filelisttable">
			   <thead>
				<tr>

					<th align="left">
						<div class="width-50px">
							
						</div>
					</th>
					<th align="left">
						<div class="width-270px">
							Filename
						</div>
					</th>
					<!--- <th align="left">
						<div class="width-200px">
							Description
						</div>
					</th> --->
					<th align="left">
						<div class="width-40px"></div>
					</th>
			    </tr>
			   </thead>
			</table> 
		</div>
		<div class="clear"></div>
	</div><!--- end row --->

	
	<div class="clear"></div>
	
	<div class="row-head width-800px">
		<div class="inlineStrip-right">
			<div id="progressbar" style="float:left; width:300px;"><div class="progress-label"></div></div>
			<button type="button" class="btn btn-default" name="pickfiles" id="pickfiles">Browse Files</button>
			<button type="button" class="btn btn-default" name="uploadfiles" id="uploadfiles">Upload Files</button>
			<button type="button" class="btn btn-default" name="closeBtn" id="closeBtn" onClick="window.opener.resultFromPopup(true); window.close(); return false;">Close</button>
		</div>
	</div>	
</div>


<script type="text/javascript">
	
	if (window.FileReader) {
	console.log('FileReader API OK');
	} else {
	  console.log('The FileReader APIs are not fully supported in this browser.');
	}


var params = {};  // Params from GET
if (location.search) {
    var parts = location.search.substring(1).split('&');

    for (var i = 0; i < parts.length; i++) {
        var nv = parts[i].split('=');
        if (!nv[0]) continue;
        params[nv[0]] = nv[1] || true;
    }
}


var uploader = new plupload.Uploader({
	runtimes : 'html5',
	browse_button : 'pickfiles',
	container: 'container',
	<!--- max_file_size : '70mb', --->
	url : 'model/userService.cfc?method=UploadFileCall',
	dragdrop : true,
	multi_selection: false,
	drop_element: "container",
	enctype:"multipart/form-data",
    max_file_size: '10485760mb',
    chunk_size: '15mb',
    unique_names: false

});


uploader.bind('Init', function(up, params) {
	console.log("Current plupload runtime: " + params.runtime );	
});

uploader.bind('FilesAdded', function(up, files) {
	console.log( 'FilesAdded' );
	console.log(files);
	
	if (files.length == 1) {
		console.log("IN");
		var isImageOK=true;
		for (var i in files) {
			//Remove from file name everything except letters, numbers, !, . and space
			files[i].name = files[i].name.replace(/[^a-zA-Z0-9!. ]+/g, "");

			var isImageOK=true;
			// Check file extension	
			var fileExt = files[i].name.split('.').pop().toLowerCase();
			var extList= ['jpg','jpeg','gif','png','bmp','tif','ai','pdf'];

			if ( (files[i].size > 100*1024*1024) && (fileExt!='ai') ) {  // Check file size before upload
				alert('Max file size is 100 MB!');
				up.removeFile( files[i] );
				return false;
				}
			if ((files[i].size > 2048*1024*1024) && (fileExt=='ai') ) {  // Check file size before upload
				alert('Max file size for ai files is 2 GB!');
				up.removeFile( files[i] );
				return false;
				}

			/*if (params['GraphicsType'].search(/pattern/i) != -1)
				extList= ['jpg','jpeg','gif','png','bmp','tif','ai','pdf', 'eps','zip','dxf','rul'];
			
			if (jQuery.inArray(fileExt, extList) ==-1){ // TODO:  ugly, should read from plupload.settings..., Igor
				alert('file type "' + fileExt + '" not supported!');
				this.removeFile( files[i] );
				return false;
			}*/

			// Create new table row
			if (isImageOK){
			$('##filelisttable').append('<tr id="'+files[i].id+'" >'+
				'<td style="width:175px;"><img class="thumb" src="##" alt="image preview" width="150px" onerror="imageError(\''+files[i].id+'\')" >'+
				'<td style="vertical-align:middle;">'+files[i].name + ' (' + plupload.formatSize(files[i].size) + ')<span id="span'+files[i].id+'"> 0%</span>'+

				'</td>'+
				/*'<td><textarea class="input width-235px height-50px" id="description'+files[i].id+'" rows="2" ></textarea></td>'+*/
				'<td style="vertical-align:middle;"><a href="##"><img src="assets/img/errorX.png" alt="delete image" width="18px" height="18px" onclick="removeUploadedFile(this);"></a></td>'+
			'</tr>');

			if (fileExt=='ai'){
			   $('##'+files[i].id+' td img[class=thumb]').attr("src", "assets/img/ai-upload.png");
			   } 
			if(fileExt=='pdf'){
			   $('##'+files[i].id+' td img[class=thumb]').attr("src", "assets/img/pdf-upload.png");
			   }
			}
			
	// /*	
		// live  thumbnail before upload, work fine in chrome, firefox,
		// http://www.plupload.com/punbb/viewtopic.php?pid=5744
			var imgExtList= ['jpg','jpeg','gif','png','bmp','tif'];
			if (jQuery.inArray(fileExt, imgExtList) !=-1)
	         // try 
	          {          
	          	var file = files[i];

	            var img = document.createElement("img");
	            img.file = file.nativeFile;
	            var reader = new FileReader();

	            reader.onload = (function(aImg, aFile) { 
	              return function(e) { 
					try{
	                $('##'+aFile.id+' td img[class=thumb]').attr("src", e.target.result);
	                //$('##thumb').attr("src", e.target.result);
	                
					}
					catch(e){alert('ji')}
					
					console.log(aFile.id+' e.target.result:  '+e.target.result);
					
	                
	              }; })(img, file);


	    
				reader.readAsDataURL(file.nativeFile);	 
	            	
	          }
	          
	         // catch (e) { alert('Image corrupted!'); isImageOK=false; this.removeFile( files[i] );} 



		// end live  thumbnail
	//	*/	


		} // end for
	} else {
		alert("You can upload only one image!");
		for (var j in files) {
			up.removeFile( files[j] );	
			files = [];		
		}
		console.log("Files: "+files);
	}
	
	
});

function imageError(fileId){
	removeUploadedFilebyId(fileId);
	alert('Image corrupted!');
}

uploader.bind('UploadProgress', function(up, file) {
	$('##span'+file.id).text(file.percent + "%");
});

uploader.bind('FileUploaded', function(up, file, response) {
	console.log(file.id+', '+ response);
	$("##file").val(file.name);
	$('##'+file.id).remove();  // Remove from view
	this.removeFile( file );  // Remove from queue
	$( "##progressbar" ).progressbar( "value", 100 );
	
	//alert(response);
});

uploader.bind('UploadComplete', function(up, file) {
	console.log('UploadComplete');
	console.log(file);
	window.opener.resultFromPopup($("##file").val());
	window.close(); 
});


uploader.bind('BeforeUpload', function(up, file) {

// Additional params to send with uploaded file
	up.settings.multipart_params = {
                            "type": params.type,
<!---                        "format": $('##'+file.id+' td select').val(), --->
                           	"format": '0',
                            "description": $('##'+file.id+' td textarea').val(),
                            "PCVersionUID": '#fPCVersionUID#',
                            "SOIVersionUID": '#fSOIVersionUID#',
                            "Sector": params.Sector
                            
                        };
});

document.getElementById('uploadfiles').onclick = function() {
	uploader.start();
	return false;
};

uploader.bind('UploadProgress', function(up, file) {
	console.log(file.percent);
	 $( "##progressbar" ).progressbar( "value", file.percent );
	if(file.percent == 100)  $( "##progressbar" ).progressbar( "value", 100 ); //$('##SketchMainImgProgress').text('Upload finished.');;
});

uploader.init();


//helper functions
function removeUploadedFile(fid){
	var id =  $(fid).parent().parent().parent().prop('id') ;
	console.log( id );
	var file = uploader.getFile(id);
	$('##'+id).remove();
	uploader.removeFile( file );
}
function removeUploadedFilebyId(id){
	var file = uploader.getFile(id);
	$('##'+id).remove();
	uploader.removeFile( file );
}


 function bntUploadClick(){

	// creating an instance of the proxy class. 
	//var jspc = new jsobj_pcg();
	// Setting a callback handler for the proxy automatically makes
	// the proxy's calls asynchronous.
	//jspc.setCallbackHandler(callbckimefje);
	// Setting the Error Handler to handle error
	//jspc.setErrorHandler(globalErrorHandler);
	//Invoke our cold fusion component method and pass the parameters
	//jspc.UploadFileCall('tip5');
}
function callbckimefje(nekiresponce){
	console.log(nekiresponce);
}
if ( window.chrome) $('##pickfiles').hide();
</script>

</cfoutput>

