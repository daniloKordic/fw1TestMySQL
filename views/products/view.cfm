<cfoutput>

	<cfset fProductUID=""/>
	<cfset fProductName=""/>
	<cfset fProductDescription=""/>	

	<cfif rc.product.recordCount neq 0>
		<cfset fProductUID="#rc.product.ProductUID#" />
		<cfset fProductName="#rc.product.ProductName#"/>
		<cfset fProductDescription="#rc.product.ProductDescription#"/>
	</cfif>

	<div id="productPhotos">
		<div id="thumbnails">
			<ul class="clearfix ProductImagess" style="margin-left:0 !important;">
				<cfset imagesList = "#rc.product.images#" />
				<cfloop list="#imagesList#" index="i" delimiters=",">
					<li>
						<div class="imageHolder">
							<span class="helper"></span>
							<a href="#application.ImagesDirRel#original/#i#" title="Turntable by Jens Kappelmann">
								<img src="#application.ImagesDirRel##i#" alt="turntable">
							</a>
						</div>
					</li>          
				</cfloop>                                                            
			</ul>
		</div>
	</div>

	<div id="productInfo">
		<h2>#fProductName#</h2>
		<h4>#fProductDescription#</h4>
	</div>
	<script type="text/javascript">

		$(document).ready(function() {
			$('##thumbnails a').lightBox();
		});

	</script>

</cfoutput>