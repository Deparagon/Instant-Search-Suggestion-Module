
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


<div id="search_block" class="block exclusive">
	<h4 class="title_block">{l s='Search' mod='tomcategorysearch'}</h4>
	<form id="searchbox" method="get" action="{$link->getPageLink('search', null, null, null, false, null, true)|escape:'html':'UTF-8'}" >
		<input type="hidden" name="controller" value="search" />
		<input type="hidden" name="orderby" value="position" />
		<input type="hidden" name="orderway" value="desc" />
<!-- search data -->

<div class="input-group">
  <div class="input-group-addon">
    <select id="sfcategory">
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
  <input type="text" name="search_query" id="tcsearchdata" placeholder ="Search ..." class="form-control searchbox">
    <div class="input-group-btn">
<button class="btn btn-default searchbtn" id="submitdetailsearch" type="submit"> <i class="icon-search"> </i></button>
    </div>
</div>


<!-- /search -->
<div id="displayajaxsearchresult"> <!--AJAX RESULT --> </div>
	</form>


</div>