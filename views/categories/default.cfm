
<cfoutput>

<script type="text/javascript">
	$(document).ready(function() {
		$("##newCategory").click(function() {
			document.location="index.cfm?action=categories.manage";
		});
		$("##backBtn").click(function() {
			document.location="index.cfm";
		});
	});

  function deleteCategory(uid, hasChildren) {
    if (hasChildren != 0) {
      alert("Category has subcategories!\r\nPlease delete subcategories first!");
    } else {
      $("##categoryUID").val(uid);
      $("##fsw").val("delete");

      $("##manageCategories").submit();
    }
  }
</script>

<cfif isDefined("rc.event.result.message") and rc.event.result.message neq "">
  <div class="alert alert-info expired">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    #rc.event.result.message#
  </div>
</cfif>

  <h2>Categories Management</h2>

  <form class="form-horizontal" action="#buildUrl('categories.manage')#" method="POST" id="manageCategories" name="manageCategories">
    <input type="hidden" id="fsw" name="fsw" value=""/>
    <input type="hidden" id="categoryUID" name="categoryUID" value="" />
    
    <div class="well">
        <table class="table">
          <thead>
            <tr>
              <th style="text-align:center;width:30px;">##</th>
              <th style="text-align:center;width:300px;">Category Name</th>
              <th style="text-align:center;width:370px;">Category Description</th>
              <th style="text-align:center;width:290px;">Parent</th>
              <th style="width:56px;"></th>
            </tr>
          </thead>
          <tbody>
            <cfset count = 1/>
          	<cfloop query="rc.qGrid">              
              <cfif ParentUID eq "">
                <cfset tCategoryUID="#CategoryUID#" />
                <tr>
                  <td>#count#</td>
                  <td>                  
                    <a href="index.cfm?action=categories.manage&uid=#CategoryUID#">#CategoryName#</a>
                  </td>
                  <td>#CategoryDetails#</td>
                  <td>#Parent#</td>
                  <td>
                      <a href="index.cfm?action=categories.manage&uid=#CategoryUID#"><i class="icon-pencil"></i></a>
                      <a href="##" onClick="deleteCategory('#CategoryUID#',#hasChildren#)"><i class="icon-remove"></i></a>
                  </td>
                </tr> 
                <cfloop query="#rc.qGrid#">
                  <cfif ParentUID eq tCategoryUID>
                    <cfset count = count+1 />
                    <cfset ttCategoryUID = "#CategoryUID#" />
                    <tr>
                      <td>#count#</td>
                      <td>                  
                        <a href="index.cfm?action=categories.manage&uid=#CategoryUID#">&nbsp;&nbsp;#CategoryName#</a>
                      </td>
                      <td>#CategoryDetails#</td>
                      <td>#Parent#</td>
                      <td>
                          <a href="index.cfm?action=categories.manage&uid=#CategoryUID#"><i class="icon-pencil"></i></a>
                          <a href="##" onClick="deleteCategory('#CategoryUID#',#hasChildren#)"><i class="icon-remove"></i></a>
                      </td>
                    </tr>
                    <cfloop query="#rc.qGrid#">
                      <cfif ParentUID eq ttCategoryUID>
                        <cfset count = count+1 />
                        <cfset ttCategoryUID = "#CategoryUID#" />
                        <tr>
                          <td>#count#</td>
                          <td>                  
                            <a href="index.cfm?action=categories.manage&uid=#CategoryUID#">&nbsp;&nbsp;&nbsp;&nbsp;#CategoryName#</a>
                          </td>
                          <td>#CategoryDetails#</td>
                          <td>#Parent#</td>
                          <td>
                              <a href="index.cfm?action=categories.manage&uid=#CategoryUID#"><i class="icon-pencil"></i></a>
                              <a href="##" onClick="deleteCategory('#CategoryUID#',#hasChildren#)"><i class="icon-remove"></i></a>
                          </td>
                        </tr>
                        <cfloop query="#rc.qGrid#">
                          <cfif ParentUID eq ttCategoryUID>
                            <cfset count = count+1 />
                            <cfset tttCategoryUID = "#CategoryUID#" />
                            <tr>
                              <td>#count#</td>
                              <td>                  
                                <a href="index.cfm?action=categories.manage&uid=#CategoryUID#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#CategoryName#</a>
                              </td>
                              <td>#CategoryDetails#</td>
                              <td>#Parent#</td>
                              <td>
                                  <a href="index.cfm?action=categories.manage&uid=#CategoryUID#"><i class="icon-pencil"></i></a>
                                  <a href="##" onClick="deleteCategory('#CategoryUID#',#hasChildren#)"><i class="icon-remove"></i></a>
                              </td>
                            </tr>
                          </cfif>
                        </cfloop>
                      </cfif>
                    </cfloop>
                  </cfif>
                </cfloop>
                <cfset count = count + 1/>
              </cfif>          		
          	</cfloop>
          </tbody>
        </table>
    </div>
  </form>

</cfoutput>