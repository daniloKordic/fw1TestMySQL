<cfoutput>

<form name="registerForm" id="registerForm" action="#buildUrl('register.register')#" method="post">
	<input type="hidden" id="fsw" name="fsw" value="" />

	<h2 class="form-signin-heading">Register User</h2>
	<div class="control-group"> 		
 		<div class="controls">
 			<input type="text" value="" name="firstName" id="registerFirstName" class="input-large" placeholder="First Name">
 		</div>
 	</div>
 	<div class="control-group"> 		
 		<div class="controls">
 			<input type="text" value="" name="lastName" id="registerLastName" class="input-large" placeholder="Last Name">
 		</div>
 	</div> 			
 	<div class="control-group"> 		
 		<div class="controls">
			<input type="text" value="" name="email" id="registerEmail" class="input-large" placeholder="Email address" required>
 		</div>
 	</div>			
	<div class="control-group"> 		
 		<div class="controls">
			<input type="text" value="" name="username" id="registerUsername" class="input-large" placeholder="Username" required>
 		</div>
 	</div>			
	<div class="control-group"> 		
 		<div class="controls">
			<input type="password" value="" name="password" id="registerPassword" class="input-large" placeholder="Password" required>
 		</div>
 	</div>			

	
	<button class="btn btn-primary" type="submit" id="registerBtn" name="registerBtn">Register</button>
	<button class="btn" type="button" id="cancelBtn">Cancel</button>
</form>

	<style type="text/css">
		label.valid {
			width: 22px;
			height: 22px;
			background: url(assets/img/valid.png) center center no-repeat;
			display: inline-block;
			text-indent: -9999px;
		}
		label.error {
			font-weight: bold;
			color: red;
			padding: 0 8px;
			margin-top: 2px;
			top: -5px;
		}
	</style>

<script type="text/javascript">
	$(document).ready(function() {

		$('##registerForm').validate(
			{
			rules: {
				email: {
					required: true,
					email: true
				},
				username: {
					minlength: 6,
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

		$("##registerBtn").click(function() {
			$("##fsw").val("save");
			$("##registerForm").submit();
		});

		$("##cancelBtn").click(function() {
			$("##registerFirstName").val("");
			$("##registerLastName").val("");
			$("##registerEmail").val("");
			$("##registerUsername").val("");
			$("##registerPassword").val("");
		});
	});
</script>
</cfoutput>