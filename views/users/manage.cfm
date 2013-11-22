<cfoutput>
	<cfajaxproxy cfc="#application.com#.userService" jsclassname="jsobj_usr" />

	<cfset fUserUID="" />
	<cfset fFirstName="" />
	<cfset fLastName="" />
	<cfset fEmail="" />
	<cfset fUsername=""/>
	<cfset fPassword="" />
	<cfset fActive=""/>
	<cfset fTypeID=""/>
	<cfset fUserImage=""/>
	<cfset fAddress=""/>
	<cfset fTimezone=""/>
	<cfset fPhone=""/>

	<cfif isDefined("url.uid") and url.uid neq "">	
		<cfset fUserUID="#rc.event.user.getUID()#" />
		<cfset fFirstName="#rc.event.user.getFirstName()#" />
		<cfset fLastName="#rc.event.user.getLastName()#" />
		<cfset fEmail="#rc.event.user.getEmail()#" />
		<cfset fUsername="#rc.event.user.getUsername()#"/>
		<cfset fPassword="#rc.event.user.getPassword()#" />
		<cfset fTypeID="#rc.event.user.getTypeID()#"/>
		<cfset fActive="#rc.event.user.getIsActive()#"/>
		<cfset fUserImage="#rc.event.user.getUserImage()#"/>
		<cfset fAddress="#rc.event.user.getAddress()#"/>
		<cfset fTimezone="#rc.event.user.getTimezone()#"/>
		<cfset fPhone="#rc.event.user.getPhone()#"/>	
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
			$("##phone").val("#fPhone#");
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

						<div class="well">
						    <ul class="nav nav-tabs">
						      <li class="active"><a href="##home" data-toggle="tab">Profile</a></li>
						      <cfif fUserUID neq "">
						      	<li><a href="##profile" data-toggle="tab">Password</a></li>
						      </cfif>						      
						    </ul>
						    <div id="myTabContent" class="tab-content">
						      <div class="tab-pane active in" id="home">
						        <!--- <form id="tab"> --->

					        		<div class="control-group">
									  <label class="control-label" for="username">Username:</label>
									  <div class="controls">
									    <input id="username" name="username" class="input-xlarge" type="text" value="#fUsername#">			    
									  </div>
									</div>

						            <cfif fUserUID eq "">
						            	<div class="control-group">
										  <label class="control-label" for="password">Password:</label>
										  <div class="controls">
										    <input id="password" name="password" class="input-xlarge" type="password" value="#fPassword#">			    
										  </div>
										</div>
						            </cfif>

						            <div class="control-group">
									  <label class="control-label" for="firstName">First Name:</label>
									  <div class="controls">
									    <input id="firstName" name="firstName" class="input-xlarge" type="text" value="#fFirstName#">			    
									  </div>
									</div>										

						            <div class="control-group">
									  <label class="control-label" for="lastName">Last Name:</label>
									  <div class="controls">
									    <input id="lastName" name="lastName" class="input-xlarge" type="text" value="#fLastName#">			    
									  </div>
									</div>
						            
						            <div class="control-group">
									  <label class="control-label" for="email">Email:</label>
									  <div class="controls">
									    <input id="email" name="email" class="input-xlarge" type="text" value="#fEmail#">			    
									  </div>
									</div>
						            
						            <div class="control-group">
									  <label class="control-label" for="address">Address:</label>
									  <div class="controls">
									  	<textarea id="address" name="address" rows="3" class="input-xlarge">#fAddress#</textarea>
									  </div>
									</div>
						            
						            <div class="control-group">
									  <label class="control-label" for="phone">Phone:</label>
									  <div class="controls">
									    <input id="phone" name="phone" class="input-xlarge" type="text" value="#fPhone#">			    
									  </div>
									</div>
									
									<cfif session.auth.TypeID eq 1>
										<div class="control-group">
										  <label class="control-label" for="userType">User Type:</label>
										  <div class="controls">
										    <select name="typeID" id="typeID" class="input-xlarge">
							              		<option value="">Please select...</option>		    
							              		<option value="2" <cfif fTypeID eq 2>selected</cfif>>Registered User</option>
							              		<option value="4" <cfif fTypeID eq 4>selected</cfif>>Company</option>
							              	</select>
										  </div>
										</div>	
									</cfif>

						            <div class="control-group">
										  <label class="control-label" for="timezonee">Time Zone:</label>
										  <div class="controls">
										  	 <select name="timezonee" id="timezonee" class="input-xlarge">
							              <option value="">Please select...</option>
							              <option value="-12.0" <cfif fTimezone eq "-12.0">selected</cfif>>(GMT -12:00) Eniwetok, Kwajalein</option>
							              <option value="-11.0" <cfif fTimezone eq "-11.0">selected</cfif>>(GMT -11:00) Midway Island, Samoa</option>
							              <option value="-10.0" <cfif fTimezone eq "-10.0">selected</cfif>>(GMT -10:00) Hawaii</option>
							              <option value="-9.0" <cfif fTimezone eq "-9.0">selected</cfif>>(GMT -9:00) Alaska</option>
							              <option value="-8.0" <cfif fTimezone eq "-8.0">selected</cfif>>(GMT -8:00) Pacific Time (US & Canada)</option>
							              <option value="-7.0" <cfif fTimezone eq "-7.0">selected</cfif>>(GMT -7:00) Mountain Time (US & Canada)</option>
							              <option value="-6.0" <cfif fTimezone eq "-6.0">selected</cfif>>(GMT -6:00) Central Time (US & Canada), Mexico City</option>
							              <option value="-5.0" <cfif fTimezone eq "-5.0">selected</cfif>>(GMT -5:00) Eastern Time (US & Canada), Bogota, Lima</option>
							              <option value="-4.0" <cfif fTimezone eq "-4.0">selected</cfif>>(GMT -4:00) Atlantic Time (Canada), Caracas, La Paz</option>
							              <option value="-3.5" <cfif fTimezone eq "-3.5">selected</cfif>>(GMT -3:30) Newfoundland</option>
							              <option value="-3.0" <cfif fTimezone eq "-3.0">selected</cfif>>(GMT -3:00) Brazil, Buenos Aires, Georgetown</option>
							              <option value="-2.0" <cfif fTimezone eq "-2.0">selected</cfif>>(GMT -2:00) Mid-Atlantic</option>
							              <option value="-1.0" <cfif fTimezone eq "-1.0">selected</cfif>>(GMT -1:00 hour) Azores, Cape Verde Islands</option>
							              <option value="0.0" <cfif fTimezone eq "0.0">selected</cfif>>(GMT) Western Europe Time, London, Lisbon, Casablanca</option>
							              <option value="1.0" <cfif fTimezone eq "1.0">selected</cfif>>(GMT +1:00 hour) Brussels, Copenhagen, Madrid, Paris</option>
							              <option value="2.0" <cfif fTimezone eq "2.0">selected</cfif>>(GMT +2:00) Kaliningrad, South Africa</option>
							              <option value="3.0" <cfif fTimezone eq "3.0">selected</cfif>>(GMT +3:00) Baghdad, Riyadh, Moscow, St. Petersburg</option>
							              <option value="3.5" <cfif fTimezone eq "3.5">selected</cfif>>(GMT +3:30) Tehran</option>
							              <option value="4.0" <cfif fTimezone eq "4.0">selected</cfif>>(GMT +4:00) Abu Dhabi, Muscat, Baku, Tbilisi</option>
							              <option value="4.5" <cfif fTimezone eq "4.5">selected</cfif>>(GMT +4:30) Kabul</option>
							              <option value="5.0" <cfif fTimezone eq "5.0">selected</cfif>>(GMT +5:00) Ekaterinburg, Islamabad, Karachi, Tashkent</option>
							              <option value="5.5" <cfif fTimezone eq "5.5">selected</cfif>>(GMT +5:30) Bombay, Calcutta, Madras, New Delhi</option>
							              <option value="5.75" <cfif fTimezone eq "5.75">selected</cfif>>(GMT +5:45) Kathmandu</option>
							              <option value="6.0" <cfif fTimezone eq "6.0">selected</cfif>>(GMT +6:00) Almaty, Dhaka, Colombo</option>
							              <option value="7.0" <cfif fTimezone eq "7.0">selected</cfif>>(GMT +7:00) Bangkok, Hanoi, Jakarta</option>
							              <option value="8.0" <cfif fTimezone eq "8.0">selected</cfif>>(GMT +8:00) Beijing, Perth, Singapore, Hong Kong</option>
							              <option value="9.0" <cfif fTimezone eq "9.0">selected</cfif>>(GMT +9:00) Tokyo, Seoul, Osaka, Sapporo, Yakutsk</option>
							              <option value="9.5" <cfif fTimezone eq "9.5">selected</cfif>>(GMT +9:30) Adelaide, Darwin</option>
							              <option value="10.0" <cfif fTimezone eq "10.0">selected</cfif>>(GMT +10:00) Eastern Australia, Guam, Vladivostok</option>
							              <option value="11.0" <cfif fTimezone eq "11.0">selected</cfif>>(GMT +11:00) Magadan, Solomon Islands, New Caledonia</option>
							              <option value="12.0" <cfif fTimezone eq "12.0">selected</cfif>>(GMT +12:00) Auckland, Wellington, Fiji, Kamchatka</option>
							            </select>
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
										<cfelse>
											<input type="hidden" id="active" name="active" value="#fActive#" />
										</cfif>
						      </div>
						      <div class="tab-pane fade" id="profile">
						    	<!--- <form id="tab2"> --->
						    	<cfif fUserUID neq "">
						    		<div class="control-group">
									  <label class="control-label" for="password">Password:</label>
									  <div class="controls">
									    <input id="password" name="password" class="input-xlarge" type="password" value="#fPassword#">			    
									  </div>
									</div>
						    	</cfif>			
						      </div>
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
		</fieldset>
	</form>

</cfoutput>