<cfoutput>

	<cfset fStoreUID=""/>
	<cfset fStoreName=""/>
	<cfset fStoreAddress=""/>
	<cfset fStorePhone=""/>	
	<cfset fStoreEmail=""/>
	<cfset fStoreLogo=""/>	

	<cfif structKeyExists(rc, "company")>
		<cfset fStoreUID="#rc.company.getUID()#"/>
		<cfset fStoreName="#rc.company.getFirstName()# #rc.company.getLastName()#" />
		<cfset fStoreAddress="#rc.company.getAddress()#"/>
		<cfset fStorePhone="#rc.company.getPhone()#"/>
		<cfset fStoreEmail="#rc.company.getEmail()#"/>
		<cfset fStoreLogo="#rc.company.getUserImage()#"/>
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
		function initialize() {
	        var mapOptions = {
	          center: new google.maps.LatLng(-34.397, 150.644),
	          zoom: 15
	        };
	        var map = new google.maps.Map(document.getElementById("map-canvas"),
	            mapOptions);
	        var geocoder = new google.maps.Geocoder();
		    geocoder.geocode({ 'address': '#reReplace(fStoreAddress,"  "," ","all")#' }, function (results, status) {
		                if (status == google.maps.GeocoderStatus.OK) {
		                    map.setCenter(results[0].geometry.location);
		                    var marker = new google.maps.Marker({
		                        map: map,
		                        position: results[0].geometry.location,
		                    });
		                } else 
		                  var map = new google.maps.Map(document.getElementById("map-canvas"),mapOptions);

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
				embedpano({
					swf:"tours/tour1/tour.swf", 
					xml:"tours/tour1/tour.xml", 
					target:"pano", 
					html5:"never", 
					passQueryParameters:"true"
				});
			</script>
		</div>
	</div>
	<input type="hidden" id="companyUID" name="companyUID" value="#fStoreUID#" /> 
	<div class="clear"></div>	
	<div id="companyInfo" class="row">
		<div class="span6">
			<h2>#fStoreName#</h2>
			<h5><i class="icon-home" style="margin:3px 15px 0 0;"></i>#fStoreAddress#</h5>
			<h5><i class="icon-user" style="margin:3px 15px 0 0;"></i>#fStorePhone#</h5>
			<h5>
				<i class="icon-envelope" style="margin:3px 15px 0 0;"></i>
				<a href="mailto:#fStoreEmail#">#fStoreEmail#</a>
			</h5>
			<div id="map-canvas" style="width:450px;height:500px;"></div>
		</div>
		<div class="span6">
			<div class="companyLogo">
				<img src="#application.ImagesDirRel#original/#fStoreLogo#" />
			</div>
		</div>
	</div>

	<!--- <cfdump var="#rc.company#"/> --->
</cfoutput>