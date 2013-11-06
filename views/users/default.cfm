<cfoutput>

	<script type="text/javascript">
		$(document).ready(function() {
			$("##newUser").click(function() {
				document.location="index.cfm?action=users.manage";
			});
			$("##backBtn").click(function() {
				document.location="index.cfm";
			});
		});

		function deleteUser(userUID) {
			$("##userUID").val(userUID);
			$("##fsw").val("delete");

			$("##userRegister").submit();
		}
	</script>

	<cfif isDefined("rc.event.result.message") and rc.event.result.message neq "">
		<div class="alert alert-info expired">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			#rc.event.result.message#
		</div>
	</cfif>

	<h2>User Management</h2>

	<form action="#buildUrl('users.manage')#" method="post" id="userRegister" name="userRegister" class="form-horizontal">
		<input type="hidden" id="fsw" name="fsw" value=""/>
		<input type="hidden" id="userUID" name="userUID" value=""/>
		<div class="well">
			<table class="table">
				<thead>
					<tr>
						<th style="width:50px;text-align:center;">Image</th>
						<th style="width:175px;text-align:center;">First Name</th>
						<th style="width:175px;text-align:center;">Last Name</th>
						<th style="width:175px;text-align:center;">Email</th>
						<th style="width:175px;text-align:center;">Username</th>
						<th style="width:175px;text-align:center;">Password</th>
						<th style="width:56px;"></th>
					</tr>
				</thead>
				<tbody>	
					<cfloop query="rc.qGrid">				
						<tr class="userRow">
							<td style="width:50px;text-align:center;">
								<cfif userImage neq "">
									<img style="max-width:150px;" src="#application.ImagesDirRel##userImage#">
								<cfelse>									
									NO IMAGE
								</cfif>
							</td>
							<td style="width:175px;text-align:center;">
								<a href="index.cfm?action=users.manage&uid=#userUID#">
									#FirstName#
								</a>
							</td>
							<td style="width:175px;text-align:center;">
								<a href="index.cfm?action=users.manage&uid=#userUID#">
									#LastName#
								</a>
							</td>
							<td style="width:175px;text-align:center;">
								<a href="index.cfm?action=users.manage&uid=#userUID#">
									#Email#
								</a>
							</td>
							<td style="width:175px;text-align:center;">#Username#</td>
							<td style="width:175px;text-align:center;">#Password#</td>
							<td style="width:56px;text-align:center;">
								<a href="index.cfm?action=users.manage&uid=#userUID#"><i class="icon-pencil"></i></a>
								<a href="##" onClick="deleteUser('#userUID#')"><i class="icon-remove"></i></a>
							</td>
						</tr>
					</cfloop>				
				</tbody>
			</table>
		</div>
	</form>

</cfoutput>