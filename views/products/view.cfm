<cfoutput>

	<cfset fProductUID=""/>
	<cfset fProductName=""/>
	<cfset fProductDescription=""/>	

	<cfif rc.product.recordCount neq 0>
		<cfset fProductUID="#rc.product.ProductUID#" />
		<cfset fProductName="#rc.product.ProductName#"/>
		<cfset fProductDescription="#rc.product.ProductDescription#"/>
	</cfif>

	<script src="tours/tour1/tour.js"></script>
	<script type="text/javascript">

		$(document).ready(function() {
			$('##thumbnails a').lightBox();
		});

		function test(ime) {
			window.open("index.cfm?action=register&ime="+ime, 'pozdrav', 'height=600,width=800').focus();
		}
		function vici(){
			alert("JAO!!!!");
		}
	</script>


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

	<div id="pano">
		<noscript>
			<table style="width:100%;height:100%;">
				<tr style="valign:middle;">
					<td>
						<div style="text-align:center;">
							ERROR:<br/><br/>Javascript not activated<br/><br/>
						</div>
					</td>
				</tr>
			</table>
		</noscript>
		<script>
			embedpano({
				swf:"tours/tour1/tour.swf", 
				xml:"tours/tour1/tour.xml", 
				target:"pano", 
				html5:"never", 
				passQueryParameters:"true"
			});
		</script>
	</div>
<div class="clear"></div>
	<div id="productInfo">
		<h2>#fProductName#</h2>
		<h4>#fProductDescription#</h4>
	</div>


</cfoutput>
