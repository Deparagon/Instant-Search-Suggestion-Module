
{**
 * DESCRIPTION.
 *
 * Highly Customizable Instant category search 
 * Powerful search feature that extends the default prestashop search.
 *
 *  @author    Paragon Kingsley
 *  @copyright 2015 Paragon Kingsley
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License ("AFL") v. 3.0
 *}
<!-- Block search module TOP -->
<div id="search_block_top" class="col-sm-4 clearfix">
	<form id="searchbox" method="get" action="{$link->getPageLink('search', null, null, null, false, null, true)|escape:'html':'UTF-8'}" >
		<input type="hidden" name="controller" value="search" />
		<input type="hidden" name="orderby" value="position" />
		<input type="hidden" name="orderway" value="desc" />
<!-- search data -->

<div class="input-group da-group-input">
  <div class="input-group-addon listaddonsel">
    <select id="sfcategory" class="tscatelist">
    {if isset($allselcate)}
    {asort($allselcate)|escape:'htmlall':'UTF-8'}
    <option value="All"> All </option>
    {foreach $allselcate as $k => $v}   
    	<option value="{$k|escape:'htmlall':'UTF-8'}"> {$v|escape:'htmlall':'UTF-8'}</option>
    	{/foreach}
    	{else}
    	<option value="All"> All </option>
    	{/if}
    </select>

  </div>
  <input type="text" autocomplete="off" name="search_query" id="tcsearchdata" placeholder ="Search ..." class="form-control searchbox">
    <div class="input-group-btn">
<button class="btn btn-default searchbtn" id="submitdetailsearch" type="submit"> <i class="icon-search"> </i></button>
    </div>
</div>


<!-- /search -->
<div id="displayajaxsearchresult"> <!--AJAX RESULT --> </div>
	</form>
</div>
<!-- /Block search module TOP -->
<script>
$(document).ready(function(){
   $('#displayajaxsearchresult').fadeOut();
	var ajaxurl = "{$link->getModuleLink('tomcategorysearch', 'responder')|escape:'htmlall':'UTF-8'}";

   $('#tcsearchdata').on('change keyup keydown keypress', function(){
   	if ($(this).val().length > 4){
   		 // alert($(this).val());
   		var data = {
   			'tcsearchdata':$(this).val(),
   			'sfcategory':$('#sfcategory').val(),
   			'token': 'tiskwoalea',
   		}
   		var getcomp =$.post(ajaxurl, data);
   		getcomp.success(function(rd){
         $('#displayajaxsearchresult').fadeIn();
   			$('#displayajaxsearchresult').html(rd);
   		});
   	}
    else{
     $('#displayajaxsearchresult').fadeOut();
    }
   });

$('#submitdetailsearch').click(function(){
$('#searchbox').submit();
});
});

</script>
