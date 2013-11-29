<cfoutput>

	<cfset fCategoryUID=""/>
	<cfset fStoreUID=""/>

	<cfif structKeyExists(rc, "cuid")>
		<cfset fCategoryUID="#rc.cuid#"/>		
	</cfif>
	<cfif structKeyExists(rc, "uid")>
		<cfset fStoreUID="#rc.uid#"/>
	</cfif>

	<script type="text/javascript" src="assets/js/jquery.dataTables.js"></script>
	<link rel="stylesheet" type="text/css" href="assets/css/jquery.dataTables.css" />


	<script type="text/javascript">
		$(document).ready(function() {
			$("##example").dataTable({
				"bJQueryUI": true,
				"sPaginationType": "full_numbers"
			});

			$(".productRow").click(function(){
		        window.location = $(this).attr('href');
		        return false;
		    });
		});
	</script>

	<style type="text/css">
		table tr {
			cursor: pointer;
		}
		##example_length label {
			font-size: 12px;
			font-weight: bold;
			margin: 0 0 0 5px;
		}
		##example_length select {
			margin: 5px;
			height: 20px;
			font-size: 12px;
			padding: 0;
		}
		##example_filter input {
			margin: 5px;
			height: 20px;
			padding: 0;
		}
		##example_filter label {
			font-size: 12px;
			font-weight: bold;
			margin: 0 5px 0 0;
		}
		##example_info {
			margin: 3px 0 0 5px;
		}
		##example_paginate {
			margin: 0 10px 2px 0;
			padding: 2px 0;
		}
		.ui-button {
			margin-right: 1px !important;
		}
		.productRow  td{
			border-top: 1px solid ##CCCCCC;
			border-left: 1px solid ##CCCCCC;
			border-right: 1px solid ##CCCCCC;
		}
		##example_paginate a {
			padding: 2px;
			background-color: white !important;
		}
		table.dataTable thead th {
			border-bottom: none;
		}
		table.dataTable tfoot th {
			border-top: none;
		}
		.DataTables_sort_icon {
			float: right;
		}
	</style>



	<div class="span12perc">
		<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%" style="text-align:center;">
			<thead>
				<tr>
					<th style="width:15%">Image</th>
					<th style="width:20%">Product Name</th>
					<th style="width:31%">Description</th>
					<th style="width:12%">Category</th>
					<th style="width:10%">Price</th>
					<th style="width:12%">Available</th>
				</tr>
			</thead>
			<tbody>
				<cfif rc.products.recordcount neq 0>
					<cfloop query="#rc.products#">
						<tr class="productRow" href="index.cfm?action=products.product&puid=#ProductUID#&modal=1">
							<td>
								<img src="#application.imagesDirRel##mainImage#" style="max-width:100px;max-height:100px;" />								
							</td>
							<td>#ProductName#</td>
							<td>
								<cfif len(ProductDescription) gt 93>
									#LEFT(ProductDescription,90)#...
								<cfelse>
									#ProductDescription#	
								</cfif>								
							</td>
							<td>#CategoryName#</td>
							<td>$ 5.55</td>
							<td><input type="checkbox" id="isAvailable" name="isAvailable" checked disabled /></td>
						</tr>
					</cfloop>	
				</cfif>			
			</tbody>
			<!--- <tfoot>
				<tr>
					<th>Image</th>
					<th>Product Name</th>
					<th>Description</th>
					<th>Category</th>
					<th>Price</th>
					<th>Available</th>
				</tr>
			</tfoot> --->
		</table>
	</div>
	<div class="clear"></div>

</cfoutput>