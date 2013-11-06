<cfoutput>


<cfset fTypeID = #session.auth.TypeID# />

<script type="text/javascript">
	$(document).ready(function() {
		$("##addMenuItem").click(function(){
			document.location="index.cfm?action=menu.manage";
		});

		$("##backBtn").click(function() {
			document.location="index.cfm";
		});
	});

	function deleteMenuItem(menuItemUID) {
		$("##fsw").val("delete");
		$("##menuItemUID").val(menuItemUID);
		$("##manageMenu").submit();
	}
</script>

<style type="text/css">
	.bs-example {
	    background-color: ##FFFFFF;
	    border-color: ##DDDDDD;
	    border-radius: 4px 4px 0 0;
	    border-width: 1px;
	    box-shadow: none;
	    margin-left: 0;
	    margin-right: 0;
	    margin-top: 45px;
	    padding: 45px 15px 15px;
    	position: relative;
	}
	.bs-example:after {
	    color: darkgrey;
	    content: "Menu Items";
	    font-size: 12px;
	    font-weight: bold;
	    left: 15px;
	    letter-spacing: 1px;
	    position: absolute;
	    text-transform: uppercase;
	    top: 15px;
	}
</style>

<cfif fTypeID eq 1>

	<cfif isDefined("rc.event.result.message") and rc.event.result.message neq "">
	  <div class="alert alert-info expired">
	      <button type="button" class="close" data-dismiss="alert">&times;</button>
	    #rc.event.result.message#
	  </div>
	</cfif>
		
	<h2>Menu Management</h2>
	
	<form class="form-horizontal"  action="#buildUrl('menu.manage')#" method="POST" id="manageMenu" name="manageMenu">
		<input type="hidden" name="menuItemUID" id="menuItemUID" value="" />
		<input type="hidden" id="fsw" name="fsw" value="" />

		<div class="well">
			<table class="table">
				<thead>
					<tr>
						<th>##</th>
						<th>Menu Item Level</th>
						<th>Menu Title</th>
						<th>Sort</th>
						<th>Action</th>
						<th style="width: 36px;"></th>
					</tr>
				</thead>
				<tbody>
					<cfif rc.menu.recordCount neq 0>				
						<cfloop query="#rc.menu#">	
							<cfif rc.menu.menuitemlevel eq 1>						
								<cfset tMenuItemUID = rc.menu.menuitemuid />
								<tr>
									<td>#rc.menu.currentRow#</td>
									<td>#rc.menu.menuitemlevel#</td>
									<td>#rc.menu.menuTitle#</td>
									<td>#rc.menu.sort#</td>
									<td>#rc.menu.action#</td>
									<td>
										<a href="index.cfm?action=menu.manage&uid=#tMenuItemUID#"><i class="icon-pencil"></i></a>
										<a href="##" onClick="deleteMenuItem('#tMenuItemUID#')"><i class="icon-remove"></i></a>
									</td>
								</tr>
								<cfloop query="#rc.menu#">
									<cfif rc.menu.ParentMenuItemUID eq tMenuItemUID>
										<cfset ttMenuItemUID = rc.menu.MenuItemUID />
										<tr>
											<td>#rc.menu.currentRow#</td>
											<td>#rc.menu.menuitemlevel#</td>
											<td>#rc.menu.menuTitle#</td>
											<td>#rc.menu.sort#</td>
											<td>#rc.menu.action#</td>
											<td>
												<a href="index.cfm?action=menu.manage&uid=#ttMenuItemUID#"><i class="icon-pencil"></i></a>
												<a href="##" onClick="deleteMenuItem('#ttMenuItemUID#')"><i class="icon-remove"></i></a>
											</td>
										</tr>
										<cfloop query="#rc.menu#">
											<cfset tttMenuItemUID = rc.menu.MenuItemUID />
											<cfif rc.menu.ParentMenuItemUID eq ttMenuItemUID>
												<tr>
													<td>#rc.menu.currentRow#</td>
													<td>#rc.menu.menuitemlevel#</td>
													<td>#rc.menu.menuTitle#</td>
													<td>#rc.menu.sort#</td>
													<td>#rc.menu.action#</td>
													<td>
														<a href="index.cfm?action=menu.manage&uid=#tttMenuItemUID#"><i class="icon-pencil"></i></a>
														<a href="##" onClick="deleteMenuItem('#tttMenuItemUID#')"><i class="icon-remove"></i></a>
													</td>
												</tr>
											</cfif>
										</cfloop>
									</cfif>
								</cfloop>
							</cfif>					
						</cfloop>
					<cfelse>
						<tr>
							<td colspan="5">No results</td>
						</tr>
					</cfif>				
				</tbody>
			</table>
		</div>	

	</form>
</cfif>

</cfoutput>