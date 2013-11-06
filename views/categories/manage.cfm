<cfoutput>

	<cfset fCategoryUID=""/>
	<cfset fCategoryName=""/>
	<cfset fCategoryDetails=""/>
	<cfset fParentUID=""/>
	<cfset fSort=0 />

	<cfset fCategoryUID="#rc.event.category.getCategoryUID()#"/>
	<cfset fCategoryName="#rc.event.category.getCategoryName()#"/>
	<cfset fCategoryDetails="#rc.event.category.getCategoryDetails()#"/>
	<cfset fParentUID="#rc.event.category.getParentUID()#"/>
	<cfset fSort = "#rc.event.category.getSort()#"/>

	<cfset qParentCategories = "#rc.event.Parents#" />

	<form class="form-horizontal" action="#buildUrl('categories.manage')#" method="POST" id="manageCategories" name="manageCategories">
		<input type="hidden" id="fsw" name="fsw" value=""/>
		<input type="hidden" id="CategoryUID" name="CategoryUID" value="#fCategoryUID#" />

		<cfif rc.event.result.message neq "" and rc.event.result.message neq "">
			<div class="alert alert-info expired">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
				#rc.event.result.message#
			</div>
		</cfif>

		<fieldset>
			<div id="legend">
				<legend class="">Category Info</legend>
			</div>
		<div class="control-group">
			<!-- Category Name -->
			<label class="control-label" for="CategoryName">Category Name</label>
			<div class="controls">
				<input type="text" id="CategoryName" name="CategoryName" placeholder="" value="#fCategoryName#" class="input-xlarge">
			</div>
		</div>

		<div class="control-group">
		<!-- Category Details -->
			<label class="control-label" for="CategoryDetails">Category Details</label>
			<div class="controls">
				<input type="text" id="CategoryDetails" name="CategoryDetails" placeholder="" class="input-xlarge" value="#fCategoryDetails#">
			</div>
		</div>

		<div class="control-group">
		<!-- Sort -->
			<label class="control-label" for="sort">Category Sort</label>
			<div class="controls">
				<input type="text" id="sort" name="sort" placeholder="" class="input-xlarge" value="#fSort#">
			</div>
		</div>

		<div class="control-group">
		  <label class="control-label" for="ParentUID">Select Parent</label>
		  <div class="controls">
		    <select id="ParentUID" name="ParentUID" class="input-medium">
		    	<option value="">Please select</option>
		      <cfloop query="qParentCategories">
		      	<cfif CategoryUID neq fCategoryUID>
		      		<option value="#CategoryUID#" <cfif fParentUID eq CategoryUID >selected</cfif>>#CategoryName#</option>		      		
		      	</cfif>
		      </cfloop>
		    </select>
		  </div>
		</div>

		<div class="control-group">
			<!-- Button -->
			<div class="controls">
				<button type="button" class="btn btn-success" name="updateCategory" id="updateCategory"><cfif fCategoryUID eq "">Save<cfelse>Update</cfif></button>
				<cfif fCategoryUID neq "">
					<button type="button" class="btn btn-danger" name="deleteCategory" id="deleteCategory">Delete</button>
				</cfif>				
				<button type="button" class="btn btn-default" name="backBtn" id="backBtn" type="button">Back</button>
			</div>
		</div>
		</fieldset>
	</form>

	<script type="text/javascript">

		$(document).ready(function() {

			$('##manageCategories').validate(
			{
				rules: {
					categoryName: {
						required: true,
						minlength: 3
					}
				},
				highlight: function(element) {
					$(element).closest('.control-group').removeClass('success').addClass('error');
				},
				success: function(element) {
					element.text('OK!').addClass('valid').closest('.control-group').removeClass('error').addClass('success');
				}
			});

			$("##updateCategory").click(function() {
				if (validateForm()) {
					if ($("##CategoryUID").val() == "") {
						$("##fsw").val("save");
					} else {
						$("##fsw").val("update");
					}
					//submitForm();
					$("##manageCategories").submit();
				}
			});

			$("##deleteCategory").click(function() {
				if (validateForm()) {
					$("##fsw").val("delete");
					//submitForm();
					$("##manageCategories").submit();
				}
			});

			$("##backBtn").click(function() {
				document.location = "index.cfm?action=categories";
			});
		});

		function validateForm() {
			var error = true;

			if ($("##categoryName").val() == "") { error = false; $("##categoryName").closest('.control-group').addClass("error"); }

			return error;
		}

		function submitForm() {
			$("##manageCategories").submit();
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

</cfoutput>