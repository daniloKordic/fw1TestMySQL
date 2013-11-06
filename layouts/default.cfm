<cfoutput>

	<cfparam name="rc.pageTitle" default="Product Management" />
	<cfparam name="rc.message" default="#arrayNew(1)#"/>


	<!DOCTYPE HTML>
	<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>#rc.pageTitle#</title>

		<link href="assets/bootstrap/css/bootstrap.css" rel="stylesheet" media="screen">
		<link href="assets/bootstrap/css/jasny-bootstrap.min.css" rel="stylesheet" media="screen">
		<link rel="stylesheet" type="text/css" href="assets/css/datepicker.css"/>
		<link rel="stylesheet" type="text/css" href="assets/css/jquery-ui-1.10.2.custom.css"/>
		<link href="assets/css/style.css" rel="stylesheet" media="screen">
		<link rel="stylesheet" type="text/css" href="assets/css/jquery.fancybox.css" />
		<link rel="stylesheet" type="text/css" href="assets/css/jquery.fancybox-buttons.css" />
		<link rel="stylesheet" type="text/css" href="assets/css/jquery.fancybox-thumbs.css" />

		<script type="text/javascript" src="assets/js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="assets/js/jquery.validate.js"></script>
		<script src="assets/js/jquery-ui-1.10.2.custom.js"></script>
		<script language="javascript" src="assets/js/bootstrap-datepicker.js"></script>
		<script src="assets/bootstrap/js/bootstrap.min.js"></script>
		<script src="assets/bootstrap/js/jasny-bootstrap.min.js"></script>
		<script type="text/javascript" src="assets/js/global.js"></script>
		<script type="text/javascript" src="assets/js/twitter-bootstrap-hover-dropdown.min.js"></script>
		<script type="text/javascript" src="assets/js/jquery.fancybox.pack.js"></script>
		<script type="text/javascript" src="assets/js/jquery.fancybox-buttons.js" /></script>
		<script type="text/javascript" src="assets/js/jquery.fancybox-thumbs.js" /></script>
		<script type="text/javascript" src="assets/js/jquery.fancybox-media.js" /></script>
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
			                	<cfloop query="#rc.menu#">		                		
			                		<cfset tMenuItemUID="#MenuItemUID#" />
			                		<cfif tMenuItemUID eq "3981D4BE-1A4E-4899-A919-ACB01383B8BA" and session.auth.TypeID eq 1>
			        
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

				                	<cfelseif tMenuItemUID neq "3981D4BE-1A4E-4899-A919-ACB01383B8BA">
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
			<cfif isDefined("rc.modal") and rc.modal neq 1>		
				<hr>
				<footer>
					<p>&copy; danilokordic.com 2013</p>
				</footer>
			</cfif>
		</div>		
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