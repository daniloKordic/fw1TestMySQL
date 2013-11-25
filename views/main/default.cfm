<cfoutput>
	<cfset userUID=""/>
	<cfset fullName = "Guest" />	
	<cfset usertype= 2 />
	<cfset fCategoryUID = ""/>
	<cfset fPage=1/>

	<cfif structKeyExists(session.auth, "user")>
		<cfset userUID = session.auth.user.getUID() />
		<cfset fullName = session.auth.user.getFirstName() & ' ' & session.auth.user.getLastName() />
		<cfset usertype = session.auth.user.getTypeID() />
	</cfif>	

	<cfif isDefined("rc.message") and rc.message neq "">
		<div class="alert alert-info expired">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			#rc.message#
		</div>
	</cfif>
	<!--- <cfif isDefined("rc.uid") and rc.uid neq "">
		<cfset fCategoryUID="#rc.uid#" />
	</cfif> --->

	
	<cfif isDefined("rc.cuid") and rc.cuid neq ""><cfset fCategoryUID = "#rc.cuid#" /></cfif>
	<cfif isDefined("rc.p") and rc.p neq ""><cfset fPage = "#rc.p#" /></cfif>
	<div class="container-fluid" style="padding-left:0;padding-right:0;">		
		<div class="row-fluid">
			<div class="span3New menu">

				<div class="well" style="padding: 8px 0;">
				    <div style="overflow-y: scroll; overflow-x: hidden; height: 430px;">
				        <ul class="nav nav-list">
				        		<cfloop query="#rc.categories#">
				        			<cfif parentUID eq "">
				        				<cfset tCategoryUID = CategoryUID />
				        				<cfif hasChildren neq 0>	
				        					<li><label class="tree-toggler nav-header">#CategoryName#</label>			  					
						        				<ul class="nav nav-list tree">
							        				<cfloop query="#rc.categories#">
							        					<cfif ParentUID eq tCategoryUID>						        						
							        						<cfset ttCategoryUID=CategoryUID />
							                    		<cfif hasChildren neq 0>
							                    			<li><label class="tree-toggler nav-header">#CategoryName#</label>
								                    			<ul class="nav nav-list tree">
								                    				<cfloop query="#rc.categories#">
								                    					<cfif ParentUID eq ttCategoryUID>
								                    						<cfset tttCategoryUID= CategoryUID />
								                    						<cfif hasChildren eq 0>								                    							
								                    							<li <cfif fCategoryUID eq tttCategoryUID>class="selected"</cfif>><a href="index.cfm?main&cuid=#tttCategoryUID#&p=1">#CategoryName#</a></li>
								                    						<cfelse>
								                    							<li><label class="tree-toggler nav-header">#CategoryName#</label>
												                    			<ul class="nav nav-list tree">
												                    				<cfloop query="#rc.categories#">
												                    					<cfif ParentUID eq tttCategoryUID>
												                    						<cfset ttttCategoryUID= CategoryUID />         		
												                    						<li <cfif fCategoryUID eq ttttCategoryUID>class="selected"</cfif>><a href="index.cfm?main&cuid=#tttCategoryUID#&p=1">#CategoryName#</a></li>
												                    					</cfif>
												                    				</cfloop>
												                    			</ul>
								                    						</cfif>
								                    					</cfif>
								                    				</cfloop>
								                    			</ul>
								                    		</li>
							                    		<cfelse>
							                    			<li <cfif fCategoryUID eq ttCategoryUID>class="selected"</cfif>><a href="index.cfm?main&cuid=#ttCategoryUID#&p=1">#CategoryName#</a></li>
							                    		</cfif>
							        					</cfif>
							        				</cfloop>
						        				</ul>	
						        			<cfelse>
						        				<li <cfif fCategoryUID eq tCategoryUID>class="selected"</cfif>><a href="index.cfm?main&cuid=#tCategoryUID#&p=1">#CategoryName#</a></li>
						        			</cfif>
						        		</li>	        	
				        				<li class="divider"></li>					        				
				        			</cfif>
				        		</cfloop>
				        </ul>
				    </div>
				</div>
			</div>
			<div class="span6New content" style="position:relative;">
				<ul class="thumbnails span12" style="float:left;">

					<!--- AKO NIJE IZABRANA KATEGORIJA--->
					<cfif not structKeyExists(rc, "companies")>

						<!--- AKO IMA PROIZVODA DA SE PRIKAZU --->
						<cfif rc.products.recordCount neq 0>					
							<cfloop query="#rc.products#">		
								<cfset fRowid = #rc.products.currentRow# />								
								<!--- CHECK IF ON THIS PAGE --->
								<cfif fRowid lte (#fPage#*6) and fRowid gt ((#fPage#-1)*6)>	
									<li class="span4" <cfif rc.products.currentRow mod 3 neq 0 and rc.products.currentRow mod 3 neq 2>style="margin-left:0;"</cfif>>
								   	<div class="thumbnail">
								   		<cfif mainImage neq "">
								   			<a href="index.cfm?action=companies.view&uid=#createdBy#&cuid=#CategoryUID#">
								   				<img src="#application.ImagesDirRel##mainImage#" style="width:100%;" alt="">	
								   			</a>
								   		</cfif>							   	
									   	<h4>
									   		<a href="index.cfm?action=companies.view&uid=#createdBy#&cuid=#CategoryUID#">
									   			#ProductName#
									   		</a>
									   	</h4>
									   	<p><cfif len(ProductDescription) gt 40>#left("#ProductDescription#", 37)#...<cfelse>#ProductDescription#</cfif></p>
								   	</div>
									</li>
									<cfif rc.products.currentRow mod 3 eq 0><div class="clear"></div></cfif>
								</cfif>
							</cfloop>

						<!--- AKO NEMA PROIZVODA DA SE PRIKAZU --->	
						<cfelse>
							<li class="span12" style="text-align:center;min-height:400px;vertical-align:middle;padding-top:100px;">
								<h2>No products</h2>
							</li>
						</cfif>

					<!--- AKO JE DEFINISANA KATEGORIJA --->
					<cfelse>

						<!--- AKO IMA KOMPANIJA KOJE IMAJU PROIZVODE U TOJ KATEGORIJI --->
						<cfif rc.companies.recordCount neq 0>
							<cfloop query="#rc.companies#">
								<cfset fRowid = #rc.companies.currentRow# />								
								<!--- CHECK IF ON THIS PAGE --->
								<cfif fRowid lte (#fPage#*6) and fRowid gt ((#fPage#-1)*6)>												
									<!--- <cfif CategoryUID eq fCategoryUID> --->
									<li class="span4" <cfif rc.companies.currentRow mod 3 neq 0 and rc.companies.currentRow mod 3 neq 2>style="margin-left:0;"</cfif>>
								   	<div class="thumbnail">
								   		<cfif userImage neq "">
								   			<a href="index.cfm?action=companies.view&uid=#userUID#">
								   				<img src="#application.ImagesDirRel##userImage#" style="width:100%;" alt="">	
								   			</a>
								   		</cfif>							   	
									   	<h4>										   		
									   		<a href="index.cfm?action=companies.view&uid=#userUID#">
									   			#FirstName# #LastName#
									   		</a>
									   	</h4>
									   	<p>
									   		<h6>
									   		Products in category: #numProds#
									   		</h6>
									   	</p>
								   	</div>
									</li>
									<cfif rc.companies.currentRow mod 3 eq 0><div class="clear"></div></cfif>
								</cfif>
							</cfloop>

						<!--- AKO NEMA KOMPANIJA KOJE IMAJU PROIZVODE U TOJ KATEGORIJI --->	
						<cfelse>							
							<li class="span12" style="text-align:center;min-height:400px;vertical-align:middle;padding-top:100px;">
								<h2>No products</h2>
							</li>
						</cfif>
					</cfif>
				</ul>

				<!--- PAGINATION --->
				<cfif fCategoryUID neq "">
					<div class="pagination pagination-small" style="text-align:center;position:absolute;bottom:0;width:100%;margin-bottom:5px;">
						<ul>	
							
							<!--- PREVIOUS --->
							<cfif fPage neq 1>
								<li><a href="index.cfm?main&cuid=#fCategoryUID#&p=#fPage-1#">Prev</a></li>
							<cfelse>										
								<li class="disabled"><a href="javascript:void(0);">Prev</a></li>
							</cfif>		
							<!--- PREVIOUS --->						


							<!--- PAGES --->
							<cfif rc.products.recordcount lte 6>
								<cfset fNumPages = 1/>
							<cfelse>
								<cfset fNumPages = rc.products.recordCount / 6 />							
							</cfif>							
							<cfset fLastPage = round(fNumPages / 6) + 1 />
							
							<cfif round(fNumPages) neq 0>
								<cfloop from="1" to="#fNumPages#" index="i">
									<cfif fPage eq #i#>
										<li class="active"><a href="javascript:void(0)">#i#</a></li>		
									<cfelse>
										<li><a href="index.cfm?main&cuid=#fCategoryUID#&p=#i#">#i#</a></li>		
									</cfif>
								</cfloop>
							<cfelse>
								<li class="disabled">
									<a href="javascript: void(0)">1</a>
								</li>
							</cfif>
							<!--- PAGES --->			


							<!--- NEXT --->
							<cfif fPage eq fLastPage>
								<li class="disabled">
									<a href="javascript: void(0)">Next</a>
								</li>
							<cfelse>
								<li>
									<a href="index.cfm?main&cuid=#fCategoryUID#&p=#fPage+1#">Next</a>
								</li>
							</cfif>
							<!--- NEXT --->

						</ul>
					</div>							
				</cfif>
			</div>
			<div class="span3New news">

				<cfif session.auth.typeid neq 3>				
					<div class="thumbnail center well well-small text-center">
	                <h2>Newsletter</h2>
	                
	                <p>Subscribe to our weekly<br/>Newsletter and stay tuned.</p>
	                
	                <form id="newsletterForm" action="" method="post">

	                    <div class="control-group">
						        <div class="controls">
						        	<div class="input-prepend"><span class="add-on"><i class="icon-envelope"></i></span>
						            <input type="text" name="email" id="email" placeholder="Your email address" style="width:126px;">
						         </div>
						        </div>
						    </div>

	                    <input type="button" id="newsletterBtn" onclick="registerNewsletter()" value="Subscribe Now!" class="btn btn-large" />
	              </form>
	            </div>
            </cfif>
			</div>
		</div>
		<div class="row-fluid footer">
			<div class="span4 footerColumn footerLeft">
				FOOTER1
			</div>
			<div class="span4 footerColumn footerCenter">
				FOOTER2
			</div>
			<div class="span4 footerColumn footerRight">
				FOOTER3
			</div>
		</div>
	</div>

<script type="text/javascript">
	$(document).ready(function () {
		$('label.tree-toggler').click(function () {
			$(this).parent().children('ul.tree').toggle(300);
		});
	  $('label.tree-toggler').trigger('click');

	  $('.selected').parent().parent().parent().parent().parent().children('ul.tree').toggle(300);
	  $('.selected').parent().parent().parent().parent().children('ul.tree').toggle(300);
	  $('.selected').parent().parent().parent().children('ul.tree').toggle(300);
	  $('.selected').parent().parent().children('ul.tree').toggle(300);

	  $("##newsletterForm").validate({
		    rules: {
		        email: {
		            required: true,
		            email: true
		        }
		    },
		    highlight: function (element) {
		        $(element).closest('.control-group').removeClass('success').addClass('error');
		    },
		    success: function (element) {
		        element.text('OK!').addClass('valid').closest('.control-group').removeClass('error').addClass('success');
		    }
		});
	});	

	function registerNewsletter() {
		if ($("##email").val() == "") {
			alert("Please add your email.");
		}
	}
</script>

</cfoutput>