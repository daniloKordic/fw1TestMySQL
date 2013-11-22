<cfoutput>

	<cfparam name="rc.pageTitle" default="Product Management" />
	<cfparam name="rc.message" default="#arrayNew(1)#"/>
	
	<!DOCTYPE HTML>
	<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>#rc.pageTitle#</title>

		<!---<script type="text/javascript" src="assets/js/jquery-1.9.1.js"></script>--->
		<script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>		
		
		<link href="assets/bootstrap/css/bootstrap.css" rel="stylesheet" media="screen">
		<link href="assets/bootstrap/css/jasny-bootstrap.min.css" rel="stylesheet" media="screen">
		<link rel="stylesheet" type="text/css" href="assets/css/datepicker.css"/>
		<link rel="stylesheet" type="text/css" href="assets/css/jquery-ui-1.10.2.custom.css"/>
		<link rel="stylesheet" type="text/css" href="assets/css/style.css">
		<link rel="stylesheet" type="text/css" href="assets/css/colorbox.css">
		<link rel="stylesheet" type="text/css" href="assets/css/slimbox2.css">
		<!--- <link rel="stylesheet" type="text/css" href="assets/css/blueimp-gallery.css"> --->	    
		<link rel="stylesheet" type="text/css" media="all" href="assets/css/styles.css">
		<link rel="stylesheet" type="text/css" media="all" href="assets/css/jquery.lightbox-0.5.css">	
	</head>
	<body>
		<cfif not isDefined("rc.modal")>				
				<div class="navbar navbar-inverse nav">
					<div class="navbar-inner">
						<div class="container-fluid">
							<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
			                <span class="icon-bar"></span>
			                <span class="icon-bar"></span>
			                <span class="icon-bar"></span>
			            </a>
			            <a class="brand" href="#buildUrl('main')#">
			            	<img style="height:20px;" src="assets/img/CloudPlainBlue.png" />
			            </a>
							<div class="nav-collapse collapse">
								<ul class="nav">
									
			                	<!--- MENU --->
			                	<cfif isDefined("rc.menu")>
			                		
			                	
			                	<cfloop query="#rc.menu#">		                		
			                		<cfset tMenuItemUID="#MenuItemUID#" />
			                		<cfif tMenuItemUID eq "5a5c7630-46d6-11e3-8610-e1e8e9d46ea6" and session.auth.TypeID eq 1>
			        
				                		<cfif MenuItemLevel eq 1>
				                			<cfif  isParent gt 0>  				
					                			<li class="dropdown">
					                				<a href="#buildUrl('#Action#')#" class="dropdown-toggle" data-close-others="true" data-delay="10" data-toggle="dropdown">#MenuTitle# <b class="caret"></b></a>
					                				<ul class="dropdown-menu">
					                					<cfloop query="#rc.menu#">
					                						<cfset ttMenuItemUID = "#MenuItemUID#" />
																<cfif ParentMenuItemUID eq tMenuItemUID>
																	<cfif isParent gt 0 >
																		<li class="dropdown-submenu">
										                				<a href="#buildUrl('#Action#')#">#MenuTitle#</a>
										                				<ul class="dropdown-menu">
										                					<cfloop query="#rc.menu#">
										                						<cfif ParentMenuItemUID eq ttMenuItemUID>
										                							<li><a href="#buildUrl('#Action#')#">#MenuTitle#</a></li>
										                						</cfif>
										                					</cfloop>
										                				</ul>
																	<cfelse>														
																		<li><a href="#buildUrl('#Action#')#">#MenuTitle#</a></li>
																	</cfif>
																</cfif>		                						
					                					</cfloop>
					                				</ul>
					                			</li>
					                		<cfelse>
					                			<li><a href="#buildUrl('#Action#')#">#MenuTitle#</a></li>
					                		</cfif>
				                		</cfif>

				                	<cfelseif tMenuItemUID neq "5a5c7630-46d6-11e3-8610-e1e8e9d46ea6">
				                		<cfif MenuItemLevel eq 1>
				                			<cfif  isParent gt 0>  				
					                			<li class="dropdown">
					                				<a href="#buildUrl('#Action#')#" class="dropdown-toggle" data-close-others="true" data-delay="10" data-toggle="dropdown">#MenuTitle# <b class="caret"></b></a>
					                				<ul class="dropdown-menu">
					                					<cfloop query="#rc.menu#">
					                						<cfset ttMenuItemUID = "#MenuItemUID#" />
																<cfif ParentMenuItemUID eq tMenuItemUID>
																	<cfif isParent gt 0 >
																		<li class="dropdown-submenu">
										                				<a href="#buildUrl('#Action#')#">#MenuTitle#</a>
										                				<ul class="dropdown-menu">
										                					<cfloop query="#rc.menu#">
										                						<cfif ParentMenuItemUID eq ttMenuItemUID>
										                							<li><a href="#buildUrl('#Action#')#">#MenuTitle#</a></li>
										                						</cfif>
										                					</cfloop>
										                				</ul>
																	<cfelse>														
																		<li><a href="#buildUrl('#Action#')#">#MenuTitle#</a></li>
																	</cfif>
																</cfif>		                						
					                					</cfloop>
					                				</ul>
					                			</li>
					                		<cfelse>
					                			<li><a href="#buildUrl('#Action#')#">#MenuTitle#</a></li>
					                		</cfif>
				                		</cfif>
				                	</cfif>
			                	</cfloop>

			                	</cfif>
		                	</ul>		                
								<ul class="nav pull-right">

									<cfif not session.auth.isLoggedIn>
										<li><a href="#buildUrl('register')#">Sign Up</a></li>
					               		<li class="divider-vertical"></li>
										<li class="dropdown">
											
											<a href="##" class="dropdown-toggle" data-close-others="true" data-delay="10" data-toggle="dropdown">Sign In <b class="caret"></b></a>
											<div class="dropdown-menu" style="padding: 15px; padding-bottom: 0px;">
												<form method="post" action="#buildURL('login.login')#" id="userLogin" name="userLogin">
													<input style="margin-bottom: 15px;" type="text" placeholder="E-mail" id="email" name="email" value="">
													<input style="margin-bottom: 15px;" type="password" placeholder="Password" id="password" name="password" value="">									
													<input class="btn btn-primary btn-block" type="button" id="signinBtn" value="Sign In">
												</form>
											</div>
										</li>
									<cfelse>
						               <li class="dropdown">
					                    	
					                    	<a href="##" class="dropdown-toggle" <!--- data-hover="dropdown" ---> data-close-others="true" data-delay="10" data-toggle="dropdown">Welcome, #session.auth.fullname# <b class="caret"></b></a>
					                        <ul class="dropdown-menu">
					                            <li><a href="index.cfm?action=users.manage&uid=#session.auth.user.getUID()#"><i class="icon-cog"></i> Preferences</a></li>

					                            <li><a href="##"><i class="icon-envelope"></i> Contact Support</a></li>
					                            <cfif session.auth.TypeID eq 4>
					                            	<li><a href="index.cfm?action=products&uuid=#session.auth.user.getUID()#"><i class="icon-briefcase"></i>Manage Products</a></li>
					                            </cfif>

					                            <li class="divider"></li>
					                            <li><a href="#buildUrl('login.logout')#"><i class="icon-off"></i> Logout</a></li>
					                        </ul>
					                    </li>
									</cfif>							
								</ul>
							</div>
							<!--/.nav-collapse -->
						</div>
						<!--/.container-fluid -->
					</div>
					<!--/.navbar-inner -->
				</div>			
		</cfif>
		<!--/.navbar -->

		<div class="container container-long">		
			<div class="row">
				#body#
			</div>
			<cfif not isDefined("rc.modal")>		
				<hr>
				<footer>
					<p>&copy; danilokordic.com 2013</p>
				</footer>
			</cfif>
		</div>

		
		<script type="text/javascript" src="assets/js/jquery.validate.js"></script>
		<script type="text/javascript" src="assets/js/jquery-ui-1.10.2.custom.js"></script>
		<script type="text/javascript" src="assets/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="assets/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="assets/bootstrap/js/jasny-bootstrap.min.js"></script>
		<script type="text/javascript" src="assets/js/global.js"></script>
		<script type="text/javascript" src="assets/js/twitter-bootstrap-hover-dropdown.min.js"></script>
		<script type="text/javascript" src="assets/js/jquery.colorbox-min.js"></script>
		<script type="text/javascript" src="assets/js/slimbox2.js"></script>
		<script type="text/javascript" src="assets/js/blueimp-gallery.min.js"></script>	  
		<script type="text/javascript" src="assets/js/jquery.lightbox-0.5.min.js"></script>
	</body>
	</html>

	<script type="text/javascript">
		$(document).ready(function(){
			setTimeout(function(){ 
				$(".expired").hide('slow', function(){ $(".expired").remove();});
			}, 1500 ); 

			//Handles menu drop down
			$('.dropdown-menu').find('form').click(function (e) {
				e.stopPropagation();
			});

			$("##signinBtn").click(function() {
				if (checkForm()) {
					submitForm();
				}
			});			
		});

		function checkForm() {
			var valid = 1;
			var errorText = "";

			if ($("##email").val() == "") { errorText = errorText + "Email is mandatory!\n"; valid=0; }
			if ($("##password").val() == "") { errorText = errorText + "Password is mandatory!\n"; valid=0; }

			if (errorText != "") alert(errorText);

			return valid;
		}
		function submitForm() {
			$("##userLogin").submit();
		}
	</script>

</cfoutput>