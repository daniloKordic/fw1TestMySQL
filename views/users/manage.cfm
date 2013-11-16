<cfoutput>
	<cfajaxproxy cfc="#application.com#.userService" jsclassname="jsobj_usr" />

	<cfset fUserUID="" />
	<cfset fFirstName="" />
	<cfset fLastName="" />
	<cfset fEmail="" />
	<cfset fUsername=""/>
	<cfset fPassword="" />
	<cfset fActive=""/>
	<cfset fUserImage=""/>	

	<cfif structKeyExists(rc, "event")>
		<cfset fUserUID="#rc.event.user.getUID()#" />
		<cfset fFirstName="#rc.event.user.getFirstName()#" />
		<cfset fLastName="#rc.event.user.getLastName()#" />
		<cfset fEmail="#rc.event.user.getEmail()#" />
		<cfset fUsername="#rc.event.user.getUsername()#"/>
		<cfset fPassword="#rc.event.user.getPassword()#" />
		<cfset fActive="#rc.event.user.getIsActive()#"/>
		<cfset fUserImage="#rc.event.user.getUserImage()#"/>	
	</cfif>
	

	<script type="text/javascript">

		$(document).ready(function(){
			path = '#application.ImagesDirRel#';
			$('##userRegister').validate(
			{
				rules: {
					email: {
						required: true,
						email: true
					},
					username: {
						minlength: 3,
						required: true
					},
					password: {
						minlength: 6,
						required: true
					}
				},
				highlight: function(element) {
					$(element).closest('.control-group').removeClass('success').addClass('error');
				},
				success: function(element) {
					element.text('OK!').addClass('valid').closest('.control-group').removeClass('error').addClass('success');
				}
			});

			$("##updateUser").click(function() {
				
				if (validateForm()) {					
					if ($("##userUID").val() == "") {
						$("##fsw").val("save");
					} else {
						$("##fsw").val("update");
					}
					$("##userRegister").submit();
					//submitForm();
				}
			});
			$("##deleteUser").click(function() {
				$("##fsw").val("delete");
				//submitForm();
				$("##userRegister").submit();
			});
			$("##backBtn").click(function() {
				<cfif session.auth.TypeID eq 1>
					document.location = "index.cfm?action=users";
				<cfelse>
					document.location = "index.cfm?action=main";
				</cfif>
			});

			// creating an instance of the proxy class. 
			var jsusr = new jsobj_usr();			
			jsusr.setCallbackHandler(callbckimefje);
		});

		function cancel() {
			$("##firstName").val("#fFirstName#");
			$("##lastName").val("#fLastName#");
			$("##email").val("#fEmail#");
			$("##password").val("#fPassword#");
		}
		function validateForm() {
			var error = true;

			if ($("##username").val() == "") { error = false; $("##username").closest('.control-group').addClass('error'); }
			if ($("##password").val() == "") { error = false; $("##password").closest('.control-group').addClass('error'); }
			
			return error;
		}
		function submitForm() {
			$("##userRegister").submit();
		}
		function modalWin(uid) {
		
			var result=window.showModalDialog("index.cfm?action=users.image&uid="+uid+"&modal=1","Upload",
				"dialogWidth:860px;dialogHeight:650px");
				console.log(result);
		}
		function resultFromPopup(message){
			console.log('Popup returned: ' + message);

			if (message) {
				var pathToFile=path+message;
				console.log("pathToFile: "+pathToFile);
				if ($("##UserImage").html() != "") {
					$("##UserImage").html("");
				}

				$("##UserImage").append("<img style='max-width:440px;margin-bottom:10px;' src='"+pathToFile+"' /><input type='hidden' id='userImage' name='userImage' value='"+message+"' />");
				
			}
			
			//jsusr.getFile();
		}
		function callbckimefje(fileObj){
			
		}
	</script>

	<style type="text/css">
		label.valid {
			width: 24px;
			height: 24px;
			background: url(assets/img/valid.png) center center no-repeat;
			display: inline-block;
			text-indent: -9999px;
		}
		label.error {
			font-weight: bold;
			color: red;
			padding: 2px 8px;
			margin-top: 2px;
		}
	</style>

	<cfif isDefined("rc.event.result.message") and rc.event.result.message neq "">
		<div class="alert alert-info expired">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			#rc.event.result.message#
		</div>
	</cfif>

	<form action="#buildUrl('users.manage')#" method="post" id="userRegister" name="userRegister" class="form-horizontal">
		<input type="hidden" id="fsw" name="fsw" value=""/>
		<input type="hidden" id="userUID" name="userUID" value="#fUserUID#"/>
		<fieldset>

			<!-- Form Name -->
			<cfif fUserUID neq "">
				<legend>Edit user details</legend>
			<cfelse>	
				<legend>Add user details</legend>
			</cfif>
			
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span6 pull-down-50">

						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="firstName">First Name:</label>
						  <div class="controls">
						    <input id="firstName" name="firstName" class="input-large" type="text" value="#fFirstName#">			    
						  </div>
						</div>

						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="lastname">Last Name:</label>
						  <div class="controls">
						    <input id="lastName" name="lastName" class="input-large" type="text" value="#fLastName#">		    
						  </div>
						</div>

						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="email">Email:</label>
						  <div class="controls">
						    <input id="email" name="email" class="input-large" type="text" value="#fEmail#">			    
						  </div>
						</div>

						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="username">Username:</label>
						  <div class="controls">
						    <input id="username" name="username" class="input-large" type="text" value="#fUsername#">		    
						  </div>
						</div>

						<!-- Password input-->
						<div class="control-group">
						  <label class="control-label" for="password">Password:</label>
						  <div class="controls">
						    <input id="password" name="password" class="input-large" type="password" value="#fPassword#">	    
						  </div>
						</div>

						<cfif session.auth.TypeID eq 1>
							<div class="control-group">
							  <label class="control-label" for="radios">User Status</label>
							  <div class="controls">
							    <label class="radio" for="radios-0">
							      <input name="active" id="radios-0" value="1" type="radio" <cfif fActive eq 1>checked</cfif>>
							      Active
							    </label>
							    <label class="radio" for="radios-1">
							      <input name="active" id="radios-1" value="0" type="radio" <cfif fActive eq 0>checked</cfif>>
							      Inactive
							    </label>
							  </div>
							</div>
						</cfif>

						<div class="control-group">
							<!-- Button -->
							<div class="controls">
								<button type="submit" class="btn btn-success" name="updateUser" id="updateUser"><cfif fUserUID eq "">Save<cfelse>Update</cfif></button>
								<cfif session.auth.TypeID eq 1>
									<button type="button" class="btn btn-danger" name="deleteUser" id="deleteUser">Delete</button>
								</cfif>					
								<button type="button" class="btn btn-default" name="backBtn" id="backBtn" type="button">Back</button>
							</div>
						</div>
					</div>
					<div class="span6 pull-down-50">
						<div class="row margin-top-0 padding-top-0 padding-right-0 padding-left-0 white" style="padding:0 !important;">
							<div class="tabtitle width-100 margin-bottom-10 margin-top-0">
								User Image
							</div>
							<div class="backgrey-100">
								<div id="UserImage" style="clear:both;text-align:center;">
									<cfif fUserImage neq "">
										<img style="max-width:440px;margin-bottom:10px;" src="#application.ImagesDirRel##fUserImage#" />
										<input type="hidden" id="userImage" name="userImage" value="#fUserImage#"/>
									</cfif>
								</div>
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
						<div>
							<button type="button" class="btn btn-default right margin-right-10 margin-bottom-10" name="addImage" id="addImage" type="button" onclick="modalWin('#fUserUID#')">Add Image</button>
						</div>
					</div>
				</div>
			</div>

		</fieldset>
	</form>

</cfoutput>