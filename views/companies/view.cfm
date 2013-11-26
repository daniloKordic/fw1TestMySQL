<cfoutput>

	<cfset fStoreUID=""/>
	<cfset fStoreName=""/>
	<cfset fStoreAddress=""/>
	<cfset fStorePhone=""/>	
	<cfset fStoreEmail=""/>
	<cfset fStoreLogo=""/>	
	<cfset fCategoryUID=""/>
	<cfset fProductUID=""/>
	<cfset fHotspot=""/>

	<cfif structKeyExists(rc, "company")>
		<cfset fStoreUID="#rc.company.getUID()#"/>
		<cfset fStoreName="#rc.company.getFirstName()# #rc.company.getLastName()#" />
		<cfset fStoreAddress="#rc.company.getAddress()#"/>
		<cfset fStorePhone="#rc.company.getPhone()#"/>
		<cfset fStoreEmail="#rc.company.getEmail()#"/>
		<cfset fStoreLogo="#rc.company.getUserImage()#"/>
		<cfif rc.products.recordcount neq 0 or rc.products neq "">
			<cfset fCategoryUID="#rc.products.categoryUID#"/>	
			<cfset fHotspot="#rc.products.CategoryName#"/>
		</cfif>				
	</cfif>
	<cfif structKeyExists(rc, "puid")>
		<cfset fProductUID="#rc.puid#"/>
	</cfif>

	
	<script src="tours/tour1/tour.js"></script>
	<script type="text/javascript">

		$(document).ready(function() {
			$('##thumbnails a').lightBox();	

			if ($("##productUID").val() != "") {
				var productUID=$("##productUID").val();
				window.open("index.cfm?action=products.product&puid="+productUID,"Product Info","width=1000,height=600");
			}
		});

		function test(ime) {
			console.log(ime);
			window.open("http://www.google.com","test","width=1000,height=650");
			/*if (!$("##myDialog").dialog("isOpen")) {
				$("##myDialog").dialog("open");
				return;
			}*/
		}
		function initialize() {
			var myLatlng = new google.maps.LatLng(44.850104,20.386502);
	        var mapOptions = {
	          center: myLatlng,
	          zoom: 15
	        };
	        var map = new google.maps.Map(document.getElementById("map-canvas"),
	            mapOptions);
	        
	        var marker = new google.maps.Marker({
			  position: myLatlng,
			  map: map,
			  title: '#fStoreName#'
			});

	      }
	      google.maps.event.addDomListener(window, 'load', initialize);
	</script>
	
	<div class="row">
		<div class="span12perc" id="pano">
			<noscript>
				<table style="height:100%;">
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
				var fHotspot='#fHotspot#';
				embedpano({
					swf:"tours/tour1/tour.swf", 
					xml:"tours/tour1/tour.xml", 
					target:"pano", 
					html5:"never",
					passQueryParameters: "false",
					vars: {myHotspot: fHotspot}
				});
			</script>
		</div>
	</div>
	<input type="hidden" id="companyUID" name="companyUID" value="#fStoreUID#" /> 
	<input type="hidden" id="categoryUID" name="categoryUID" value="#fCategoryUID#">
	<input type="hidden" id="productUID" name="productUID" value="#fProductUID#">
	<div class="clear"></div>	
	<div id="companyInfo" class="row">
		<div class="span6perc">
			<div class="companyLogo">
				<img src="#application.ImagesDirRel#original/#fStoreLogo#" />
			</div>
			<h2>#fStoreName#</h2>
			<h5><i class="icon-home" style="margin:3px 15px 0 0;"></i>#fStoreAddress#</h5>
			<h5><i class="icon-user" style="margin:3px 15px 0 0;"></i>#fStorePhone#</h5>
			<h5>
				<i class="icon-envelope" style="margin:3px 15px 0 0;"></i>
				<a href="mailto:#fStoreEmail#">#fStoreEmail#</a>
			</h5>
		</div>
		<div class="span6perc">			
			<div id="map-canvas" style="height:450px;"></div>
		</div>
	</div>

	<!--- MODAL --->
	<div id="myDialog">
		<table class="table">
			<thead>
				<tr>
					<th>12</th>
					<th>34</th>
					<th>56</th>
					<th>78</th>
					<th>90</th>
				</tr>
			</thead>
			<tbody>
				<!---<tr>
					<td>12</td>
					<td>43</td>
					<td>65</td>
					<td>87</td>
					<td>09</td>
				</tr>
				<tr>
					<td>12</td>
					<td>43</td>
					<td>65</td>
					<td>87</td>
					<td>09</td>
				</tr>--->
			</tbody>
		</table>
	</div>
	<!--- /MODAL --->

</cfoutput>