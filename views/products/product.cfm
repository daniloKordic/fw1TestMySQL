<cfoutput>

	<cfset fProductUID=""/>
	<cfset fProductName=""/>
	<cfset fProductDescription=""/>
	<cfset fCategoryName=""/>
	<cfset fMainImage=""/>
	<cfset fImagesList=""/>
	<cfset fStoreName=""/>
	<cfset fStoreAddress=""/>
	<cfset fStorePhone=""/>
	<cfset fStoreEmail=""/>
	<cfset fUserUID=""/>
	<cfset fRating="-1" />

	<cfif structKeyExists(rc, "product")>
		<cfset fProductUID="#rc.product.ProductUID#" />
		<cfset fProductName="#rc.product.ProductName#"/>
		<cfset fProductDescription="#rc.product.ProductDescription#"/>
		<cfset fCategoryName="#rc.product.CategoryName#"/>
		<cfset fMainImage="#rc.product.mainImage#"/>
		<cfset fImagesList="#rc.product.images#"/>		
		<cfset fStoreName="#rc.product.FirstName# #rc.product.LastName#"/>
		<cfset fStoreAddress="#rc.product.Address#"/>
		<cfset fStorePhone="#rc.product.phone#"/>
		<cfset fStoreEmail="#rc.product.email#"/>
	</cfif>

	<cfif structKeyExists(session.auth, "user")>
		<cfset fUserUID="#session.auth.user.getUID()#"/>
	</cfif>	

	<link rel="stylesheet" type="text/css" href="assets/css/rating.css">

	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDe6OAz-ivw1bg4PoTKVyQ6M0SqndG8LMc&sensor=false"></script>
	<script type="text/javascript" src="assets/js/galleria-1.3.3.js"></script>
	<script type="text/javascript" src="assets/js/bootstrap-rating-input.min.js"></script>
	<script type="text/javascript" src="assets/js/jquery.rating.js"></script>
	<script type="text/javascript">
		Galleria.configure({
			lightbox: true
		});
		Galleria.loadTheme('assets/js/galleria.classic.js');
		Galleria.run('.galleria');

		(function(e){var t,o={className:"autosizejs",append:"",callback:!1,resizeDelay:10},i='<textarea tabindex="-1" style="position:absolute; top:-999px; left:0; right:auto; bottom:auto; border:0; padding: 0; -moz-box-sizing:content-box; -webkit-box-sizing:content-box; box-sizing:content-box; word-wrap:break-word; height:0 !important; min-height:0 !important; overflow:hidden; transition:none; -webkit-transition:none; -moz-transition:none;"/>',n=["fontFamily","fontSize","fontWeight","fontStyle","letterSpacing","textTransform","wordSpacing","textIndent"],s=e(i).data("autosize",!0)[0];s.style.lineHeight="99px","99px"===e(s).css("lineHeight")&&n.push("lineHeight"),s.style.lineHeight="",e.fn.autosize=function(i){return this.length?(i=e.extend({},o,i||{}),s.parentNode!==document.body&&e(document.body).append(s),this.each(function(){function o(){var t,o;"getComputedStyle"in window?(t=window.getComputedStyle(u,null),o=u.getBoundingClientRect().width,e.each(["paddingLeft","paddingRight","borderLeftWidth","borderRightWidth"],function(e,i){o-=parseInt(t[i],10)}),s.style.width=o+"px"):s.style.width=Math.max(p.width(),0)+"px"}function a(){var a={};if(t=u,s.className=i.className,d=parseInt(p.css("maxHeight"),10),e.each(n,function(e,t){a[t]=p.css(t)}),e(s).css(a),o(),window.chrome){var r=u.style.width;u.style.width="0px",u.offsetWidth,u.style.width=r}}function r(){var e,n;t!==u?a():o(),s.value=u.value+i.append,s.style.overflowY=u.style.overflowY,n=parseInt(u.style.height,10),s.scrollTop=0,s.scrollTop=9e4,e=s.scrollTop,d&&e>d?(u.style.overflowY="scroll",e=d):(u.style.overflowY="hidden",c>e&&(e=c)),e+=w,n!==e&&(u.style.height=e+"px",f&&i.callback.call(u,u))}function l(){clearTimeout(h),h=setTimeout(function(){var e=p.width();e!==g&&(g=e,r())},parseInt(i.resizeDelay,10))}var d,c,h,u=this,p=e(u),w=0,f=e.isFunction(i.callback),z={height:u.style.height,overflow:u.style.overflow,overflowY:u.style.overflowY,wordWrap:u.style.wordWrap,resize:u.style.resize},g=p.width();p.data("autosize")||(p.data("autosize",!0),("border-box"===p.css("box-sizing")||"border-box"===p.css("-moz-box-sizing")||"border-box"===p.css("-webkit-box-sizing"))&&(w=p.outerHeight()-p.height()),c=Math.max(parseInt(p.css("minHeight"),10)-w||0,p.height()),p.css({overflow:"hidden",overflowY:"hidden",wordWrap:"break-word",resize:"none"===p.css("resize")||"vertical"===p.css("resize")?"none":"horizontal"}),"onpropertychange"in u?"oninput"in u?p.on("input.autosize keyup.autosize",r):p.on("propertychange.autosize",function(){"value"===event.propertyName&&r()}):p.on("input.autosize",r),i.resizeDelay!==!1&&e(window).on("resize.autosize",l),p.on("autosize.resize",r),p.on("autosize.resizeIncludeStyle",function(){t=null,r()}),p.on("autosize.destroy",function(){t=null,clearTimeout(h),e(window).off("resize",l),p.off("autosize").off(".autosize").css(z).removeData("autosize")}),r())})):this}})(window.jQuery||window.$);

		var __slice=[].slice;(function(e,t){var n;n=function(){function t(t,n){var r,i,s,o=this;this.options=e.extend({},this.defaults,n);this.$el=t;s=this.defaults;for(r in s){i=s[r];if(this.$el.data(r)!=null){this.options[r]=this.$el.data(r)}}this.createStars();this.syncRating();this.$el.on("mouseover.starrr","span",function(e){return o.syncRating(o.$el.find("span").index(e.currentTarget)+1)});this.$el.on("mouseout.starrr",function(){return o.syncRating()});this.$el.on("click.starrr","span",function(e){return o.setRating(o.$el.find("span").index(e.currentTarget)+1)});this.$el.on("starrr:change",this.options.change)}t.prototype.defaults={rating:void 0,numStars:5,change:function(e,t){}};t.prototype.createStars=function(){var e,t,n;n=[];for(e=1,t=this.options.numStars;1<=t?e<=t:e>=t;1<=t?e++:e--){n.push(this.$el.append("<span class='glyphicon .glyphicon-star-empty'></span>"))}return n};t.prototype.setRating=function(e){if(this.options.rating===e){e=void 0}this.options.rating=e;this.syncRating();return this.$el.trigger("starrr:change",e)};t.prototype.syncRating=function(e){var t,n,r,i;e||(e=this.options.rating);if(e){for(t=n=0,i=e-1;0<=i?n<=i:n>=i;t=0<=i?++n:--n){this.$el.find("span").eq(t).removeClass("glyphicon-star-empty").addClass("glyphicon-star")}}if(e&&e<5){for(t=r=e;e<=4?r<=4:r>=4;t=e<=4?++r:--r){this.$el.find("span").eq(t).removeClass("glyphicon-star").addClass("glyphicon-star-empty")}}if(!e){return this.$el.find("span").removeClass("glyphicon-star").addClass("glyphicon-star-empty")}};return t}();return e.fn.extend({starrr:function(){var t,r;r=arguments[0],t=2<=arguments.length?__slice.call(arguments,1):[];return this.each(function(){var i;i=e(this).data("star-rating");if(!i){e(this).data("star-rating",i=new n(e(this),r))}if(typeof r==="string"){return i[r].apply(i,t)}})}})})(window.jQuery,window);$(function(){return $(".starrr").starrr()})

		$(function(){

		  $('##new-review').autosize({append: "\n"});

		  var reviewBox = $('##post-review-box');
		  var newReview = $('##new-review');
		  var openReviewBtn = $('##open-review-box');
		  var closeReviewBtn = $('##close-review-box');
		  var ratingsField = $('##ratings-hidden');

		  openReviewBtn.click(function(e)
		  {
		    reviewBox.slideDown(400, function()
		      {
		        $('##new-review').trigger('autosize.resize');
		        newReview.focus();
		      });
		    openReviewBtn.fadeOut(100);
		    closeReviewBtn.show();
		  });

		  closeReviewBtn.click(function(e)
		  {
		    e.preventDefault();
		    reviewBox.slideUp(300, function()
		      {
		        newReview.focus();
		        openReviewBtn.fadeIn(200);
		      });
		    closeReviewBtn.hide();
		    
		  });
		});

		$(document).ready(function() {
			var userUID=$("##userUID").val();
			var productUID=$("##productUID").val();
			$('##rate1').rating("index.cfm?action=products.saveRating&uuid="+userUID+"&puid="+productUID, {maxvalue:5,increment:.5});
		});

		function initialize() {
			var myLatlng = new google.maps.LatLng(44.850104,20.386502);
			var mapOptions = {
			  center: myLatlng,
			  zoom: 14
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

		function saveReview() {
			var txt = $("##new-review").val();
			console.log("ajax call and save: "+txt);
			
		}
	</script>

	<style type="text/css">
		.galleria {
			width: 520px;
			height: 320px;
		}
		.galleria-counter {
			color: white;
			font-size: 12px;
		}
		.galleria-container {
			background: ##000;
		}
		##demo {
			height: auto;
		    margin: 0 auto;
		    width: auto;
		    padding: 12px;
		    background: none repeat scroll 0 0 ##FFFFFF;
    		box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
		}
		.row {
			background: none !important;
    		border: none !important;	
		}
		.animated {
		    -webkit-transition: height 0.2s;
		    -moz-transition: height 0.2s;
		    transition: height 0.2s;
		}
		/*.stars
		{
		    margin: 20px 0;
		    font-size: 24px;
		    color: ##d17581;
		}*/
		##new-review{
			width: 375px;
		}
	</style>
	<input type="hidden" name="userUID" id="userUID" value="#fUserUID#" /> 
	<input type="hidden" name="productUID" id="productUID" value="#fProductUID#" /> 

	<div class="span6perc" style="margin:0 !important;">
		<div id="demo">
			<div class="galleria">
				<cfloop from="1"  to="#listLen(fImagesList)#" index="i">
					<a href="#application.ImagesDirRel#original/#listGetAt("#fImagesList#", #i#)#">
						<img src="#application.ImagesDirRel##listGetAt("#fImagesList#", #i#)#" />
					</a>
				</cfloop>
			</div>
		</div>
	</div>
	<div class="span6perc">
		<div id="demo">
			<div class="span6perc">
				<h4>#fProductName#</h4>
				<!--- <input name="rating" id="rating" class="rating" type="number" data-max="4" data-min="0" !--- data-clearable="remove" --- value="#fRating#" /> --->
				<cfif fUserUID neq "">
					
				
					<div class="rating" id="rate1">
						<div class="cancel">
							<a title="Cancel Rating" href="##0">Cancel Rating</a>
						</div>
						<div class="star star-left">
							<a title="Give it 0.5/5" href="##0.5" style="width: 100%;">0.5</a>
						</div>
						<div class="star star-right">
							<a title="Give it 1/5" href="##1" style="width: 100%;">1</a>
						</div>
						<div class="star star-left">
							<a title="Give it 1.5/5" href="##1.5" style="width: 100%;">1.5</a>
						</div>
						<div class="star star-right">
							<a title="Give it 2/5" href="##2" style="width: 100%;">2</a>
						</div>
						<div class="star star-left">
							<a title="Give it 2.5/5" href="##2.5" style="width: 100%;">2.5</a>
						</div>
						<div class="star star-right">
							<a title="Give it 3/5" href="##3" style="width: 100%;">3</a>
						</div>
						<div class="star star-left">
							<a title="Give it 3.5/5" href="##3.5" style="width: 100%;">3.5</a>
						</div>
						<div class="star star-right">
							<a title="Give it 4/5" href="##4" style="width: 100%;">4</a>
						</div>
						<div class="star star-left">
							<a title="Give it 4.5/5" href="##4.5" style="width: 100%;">4.5</a>
						</div>
						<div class="star star-right">
							<a title="Give it 5/5" href="##5" style="width: 100%;">5</a>
						</div>
					</div>
				</cfif>

				<div class="clear"></div>
				<h5>$ 12.11</h5>
				<div class="clear"></div>
				<h6>#fProductDescription#</h6>
			</div>
			<div class="span6perc">
				<h4>#fStoreName#</h4>
				<div class="clear"></div>
				<b>
					#fStoreAddress#
					<div class="clear"></div>
					#fStorePhone#
					<div class="clear"></div>
					<a href="mailto:#fStoreEmail#">#fStoreEmail#</a>
				</b>
				<div class="clear"></div>
				<div id="map-canvas" style="height:280px;"></div>
			</div>
			<div class="clear"></div>	
			<cfif fUserUID neq "">				
			
				<div class="row" style="margin-top:40px;">
					<div class="col-md-6">
			    	<div class="well well-sm" style="padding:5px;margin-bottom:0;">
			            <div class="text-right">
			                <a class="btn btn-success btn-green" href="##reviews-anchor" id="open-review-box">Leave a Review</a>
			            </div>
			        
			            <div class="row" id="post-review-box" style="display:none;margin-bottom:0;">
			                <div class="col-md-6">
			                    <form accept-charset="UTF-8" action="" method="post" id="reviewFrm" name="reviewFrm">
			                        <input id="ratings-hidden" name="rating" type="hidden"> 
			                        <textarea class="form-control animated" cols="80" id="new-review" name="comment" placeholder="Enter your review here..." rows="5"></textarea>
			        
			                        <div class="text-right">
			                            <!--- <div class="stars starrr" data-rating="0"></div> --->
			                            <a class="btn btn-danger btn-sm" href="##" id="close-review-box" style="display:none; margin-right: 10px;">
			                            <span class="glyphicon glyphicon-remove"></span>Cancel</a>
			                            <button class="btn btn-success btn-lg" type="button" onclick="saveReview()">Save</button>
			                        </div>
			                    </form>
			                </div>
			            </div>
			        </div> 
			         
					</div>
				</div>

			</cfif>		
		</div>
	</div>
</cfoutput>