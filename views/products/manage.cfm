<cfoutput>

        <cfset fProductUID=""/>
        <cfset fProductName=""/>
        <cfset fProductDescription=""/>
        <cfset fIsActive=""/>
        <cfset fCategoryUID=""/>
        <cfset fNumProductPhotos="0"/>
        <cfset fProductImages=""/>
        <cfset qCategory = "" />

        <cfset fProductUID="#rc.event.product.getProductUID()#"/>
        <cfset fProductName="#rc.event.product.getProductName()#"/>
        <cfset fProductDescription="#rc.event.product.getProductDescription()#"/>
        <cfset fIsActive="#rc.event.product.getActive()#"/>
        <cfset fCategoryUID="#rc.event.product.getCategoryUID()#"/>
        <cfset fNumProductPhotos="#rc.event.product.getNumProductPhotos()#"/>
        <cfset fProductImages="#rc.event.product.getProductPhotos()#"/>
        <cfset qCategory = "#rc.event.Categories#" />

<script type="text/javascript">

                $(document).ready(function() {                        
                        path = '#application.ImagesDirRel#';

                        $('##thumbnails a').lightBox();

                        $("a[rel^='lightbox']").slimbox({
                                overlayOpacity: 0.6,
                                counterText: "Image {x} of {y}",
                                closeKeys: [27, 70],
                                nextKeys: [39, 83]
                        }, null, function(el) {
                                        return (this == el) || ((this.rel.length > 8) && (this.rel == el.rel));
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

                function modalWin(uid) {
                
                        var result=window.showModalDialog("index.cfm?action=products.image&uid="+uid+"&modal=1","Upload",
                                "dialogWidth:860px;dialogHeight:650px");
                                console.log(result);
                }
                function resultFromPopup(message){
                    var numImages = $("##numProductPhotos").val();
                    if (message) {
                        var imagesArr = message.split(',');
                        var numPhotos = $("##numProductPhotos").val();                                
                        $("##numProductPhotos").val(parseInt(numPhotos)+parseInt(imagesArr.length));
                        for (var i=0; i<imagesArr.length; i++) {                                        
                                $(".ProductImagess").append("<li><div class='imageHolder'><a href='#application.ImagesDirRel#original/"+imagesArr[i]+"' title='Turntable by Jens Kappelmann'><img src='#application.ImagesDirRel#"+imagesArr[i]+"' alt='turntable'></a><input type='hidden' id='productImage_"+(parseInt(numPhotos)+i+1)+"' name='productImage' value='"+imagesArr[i]+"' /></div></li>");
                                    
                        }

                        $('##thumbnails a').lightBox();
                    }          
                                
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
                .cboxPhoto {
                        max-width: 800px;
                        max-height: 600px;
                }
        </style>

        <form class="form-horizontal" action="#buildUrl('products.manage')#" method="POST" id="manageProduct" name="manageProduct">
                <input type="hidden" id="fsw" name="fsw" value=""/>
                <input type="hidden" id="productUID" name="productUID" value="#fProductUID#" />
                <input type="hidden" id="numProductPhotos" name="numProductPhotos" value="#listLen(fProductImages)#"/>

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
                                                                <textarea rows="3" id="productDescription" name="productDescription" class="input-xlarge">#fProductDescription#</textarea>
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
                                                <div class="row margin-top-0 padding-top-0 padding-right-0 padding-left-0 white" style="padding:0 !important;">
                                                    <div class="tabtitle width-100 margin-bottom-10 margin-top-0">
                                                            Product Images
                                                    </div>
                                                    <div class="backgrey-100">
                                                        <div id="thumbnails">
                                                            <ul class="clearfix ProductImagess" style="margin-left:0 !important;">
                                                                <cfif fProductImages neq "">
                                                                    <cfset ix = 1/>
                                                                    <cfloop list="#fProductImages#" index="i">
                                                                        <li>
                                                                        	<div class="imageHolder">
                                                                            <a href="#application.ImagesDirRel#original/#i#" title="Turntable by Jens Kappelmann">
                                                                                <img src="#application.ImagesDirRel##i#" alt="turntable">
                                                                            </a>
                                                                           </div>
                                                                        </li>          
                                                                    </cfloop>
                                                                </cfif>                                                              
                                                            </ul>
                                                        </div>
                                                    <div class="clear"></div>
                                                </div>
                                                <div class="clear"></div>
                                                <div>
                                                    <button type="button" class="btn btn-default right margin-right-10 margin-bottom-10" name="addImage" id="addImage" type="button" onclick="modalWin('#fProductUID#')">Add Images</button>
                                                </div>                                                
                                        </div>
                                </div>
                        </div>
                </fieldset>
        </form>

</cfoutput>