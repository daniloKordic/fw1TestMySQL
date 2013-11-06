<cfoutput>
	<script type="text/javascript">
	 $(document).ready(function() {

	 	$('##loginform').validate(
			{
			rules: {
				email: {
					required: true,
					email: true
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


	 	$("##registerBtn").click(function() {
	 		document.location="index.cfm?action=register";
	 	});
	 });
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

	<div class="span6">
		<form name="loginform" id="loginform" class="form-horizontal" action="#buildURL('login.login')#" method="post">
			<cfif structKeyExists(rc, "message") and rc.message neq "">
				<div class="alert alert-info expired">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
					#rc.message#
				</div>
			</cfif>
			<fieldset>
				<h2 class="form-signin-heading">Sign in</h2>
				<div class="control-group">
					<label class="control-label" for="email">Email</label>
					<div class="controls">
						<input type="text" value="" name="email" class="input-block-level" id="email" style="margin-right:10px;width:230px;">
					</div>
				</div>
				<div class="contorl-group">
					<label class="control-label">Password</label>
					<div class="controls">
						<input type="password" value="" name="password" class="input-block-level" id="password" style="margin-right:10px;width:230px;">
					</div>
				</div>
				<div class="control-group" style="text-align:right;margin:20px 50px 0 0;">
					<button class="btn btn-primary" type="submit">Sign in</button>
					<button class="btn" type="button" id="registerBtn">Register</button>
				</div>
			</fieldset>
		</form>
	</div>

</cfoutput>	