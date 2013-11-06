<cfoutput>

	<cfset fProductUID="#rc.event.product.getProductUID()#"/>
	<cfset fProductName="#rc.event.product.getProductName()#"/>
	<cfset fProductDescription="#rc.event.product.getProductDescription()#"/>
	<cfset fIsActive="#rc.event.product.getActive()#"/>
	<cfset fCategoryUID="#rc.event.product.getCategoryUID()#"/>
	<cfset qCategory = "#rc.event.Categories#" />

<script type="text/javascript">

		$(document).ready(function() {

			$(".fancybox").fancybox({
				openEffect: 'none',
				closeEffect: 'none'
			});

			$('##manageProduct').validate(
			{
				rules: {
					productName: {
						required: true,
						minlength: 6
					},
					productDescription: {
						minlength: 6,
						required: true
					},
					category: {
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

			$("##updateProduct").click(function() {
				if (validateForm()) {
					if ($("##productUID").val() == "") {
						$("##fsw").val("save");
					} else {
						$("##fsw").val("update");
					}
					//submitForm();
					$("##manageProduct").submit();
				}
			});

			$("##deleteProduct").click(function() {
				if (validateForm()) {
					$("##fsw").val("delete");
					//submitForm();
					$("##manageProduct").submit();
				}
			});

			$("##backBtn").click(function() {
				document.location = "index.cfm?action=products";
			});
		});

		function validateForm() {
			var error = true;

			if ($("##productName").val() == "") { error = false; $("##productName").closest('.control-group').addClass("error"); }

			return error;
		}

		function submitForm() {
			$("##manageProduct").submit();
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
		.fancybox img {
			max-height: 100px;
			max-width: 200px;
			margin-bottom: 4px;
			display: block;
		}
		.fancybox {
			display: inline-block;
		}
	</style>

	<form class="form-horizontal" action="#buildUrl('products.manage')#" method="POST" id="manageProduct" name="manageProduct">
		<input type="hidden" id="fsw" name="fsw" value=""/>
		<input type="hidden" id="productUID" name="productUID" value="#fProductUID#" />

		<cfif rc.event.result.message neq "" and rc.event.result.message neq "">
			<div class="alert alert-info expired">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
				#rc.event.result.message#
			</div>
		</cfif>

		<fieldset>
			<div id="legend">
				<legend class="">Product Info</legend>
			</div>

			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span6 pull-down-50">
						<div class="control-group">
							<!-- Product Name -->
							<label class="control-label" for="productName">Product Name</label>
							<div class="controls">
								<input type="text" id="productName" name="productName" placeholder="" value="#fProductName#" class="input-xlarge">
							</div>
						</div>

						<div class="control-group">
						<!-- Product Description -->
							<label class="control-label" for="productDescription">Product Description</label>
							<div class="controls">
								<textarea rows="3" id="productDescription" name="productDescription"  class="input-xlarge">#fProductDescription#</textarea>
							</div>
						</div>

						<div class="control-group">
						  <label class="control-label" for="categoryUID">Select Category</label>
						  <div class="controls">
						    <select id="categoryUID" name="categoryUID" class="input-medium input-xlarge">
						    	<option value="">Please select</option>
						      <cfloop query="qCategory">
						      	<option value="#CategoryUID#" <cfif fCategoryUID eq CategoryUID >selected</cfif>>#CategoryName#</option>
						      </cfloop>
						    </select>
						  </div>
						</div>

						<!-- Multiple Radios (inline) -->
						<div class="control-group">
							<label class="control-label" for="active">Active</label>
							<div class="controls">
							 <label class="radio inline" for="radios-1">
							   <input name="active" id="radios-1" value="1" <cfif fIsActive eq 1>checked</cfif> type="radio">
							   Yes
							 </label>
							 <label class="radio inline" for="radios-0">
							   <input name="active" id="radios-0" value="0" type="radio" <cfif fIsActive eq 0>checked</cfif>>
							   No
							 </label>
							</div>
						</div>

						<div class="control-group">
							<!-- Button -->
							<div class="controls">
								<button type="button" class="btn btn-success" name="updateProduct" id="updateProduct"><cfif fProductUID eq "">Save<cfelse>Update</cfif></button>
								<button type="button" class="btn btn-danger" name="deleteProduct" id="deleteProduct">Delete</button>
								<button type="button" class="btn btn-default" name="backBtn" id="backBtn" type="button">Back</button>
							</div>
						</div>
					</div>
					<div class="span6 pull-down-50">
						<p style="display: block;">
							<a class="fancybox" rel="gallery1" href="http://farm6.staticflickr.com/5471/9036958611_fa1bb7f827_b.jpg" title="Westfield Waterfalls - Middletown CT Lower (Graham_CS)">
								<img src="http://farm6.staticflickr.com/5471/9036958611_fa1bb7f827_m.jpg" alt="" />
							</a>
							<a class="fancybox" rel="gallery1" href="http://farm4.staticflickr.com/3824/9041440555_2175b32078_b.jpg" title="Calm Before The Storm (One Shoe Photography Ltd.)">
								<img src="http://farm4.staticflickr.com/3824/9041440555_2175b32078_m.jpg" alt="" />
							</a>
							<a class="fancybox" rel="gallery1" href="http://farm3.staticflickr.com/2870/8985207189_01ea27882d_b.jpg" title="Lambs Valley (JMImagesonline.com)">
								<img src="http://farm3.staticflickr.com/2870/8985207189_01ea27882d_m.jpg" alt="" />
							</a>
							<a class="fancybox" rel="gallery1" href="http://farm4.staticflickr.com/3677/8962691008_7f489395c9_b.jpg" title="Grasmere Lake (Phil 'the link' Whittaker (gizto29))">
								<img src="http://farm4.staticflickr.com/3677/8962691008_7f489395c9_m.jpg" alt="" />
							</a>
						</p>
					</div>
				</div>
			</div>
		</fieldset>
	</form>

</cfoutput>