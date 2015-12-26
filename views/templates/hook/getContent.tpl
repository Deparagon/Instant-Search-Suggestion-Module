
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
 <div class="row">
<div class="col-sm-12">
<div class="panel panel-default">
<div class="panel-heading">
<h4 class="panel-title"> <i class="icon-search"> </i> Category search Configuration   </h4>
</div>
<div class="panel-body">
{if isset($ok)} {if $ok eq 'ok'} <div class="alert alert-success" role="alert"> {l s='Settings Saved Successfully' mod='tomcategorysearch'} </div> {/if} {/if}
<div class="tab-holder">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#category" aria-controls="category" role="tab" data-toggle="tab">{l s='Categories' mod='tomcategorysearch'}</a></li>
    <li role="presentation"><a href="#sfields" aria-controls="sfields" role="tab" data-toggle="tab">{l s='Searchable Fields' mod='tomcategorysearch'}</a></li>
    <li role="presentation"><a href="#displayresult" aria-controls="displayresult" role="tab" data-toggle="tab">{l s='Display' mod='tomcategorysearch'}</a></li>
<li role="presentation"><a href="#showstyles" aria-controls="showstyles" role="tab" data-toggle="tab">{l s='Styles' mod='tomcategorysearch'}</a></li>

  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="category">
      <div class="panel panel-primary">
      <div class="panel-body">
      	<div class="row">
      	<div class="col-sm-2"> 
         <label> {l s='Save Changes' mod='tomcategorysearch'}</label> <br> <br>
         <button class="btn btn-block btn-info" id="savecatechanges"> {l s='Save changes' mod='tomcategorysearch'} </button> <br> 
                  
      	</div>
      	<div class="col-sm-5">
         <form name="allcategoryselectedform" id="allcategoryselectedform" class="" method="POST" action="">
         <input type="hidden"  value="igetmeseavedatcate" name="thiwcategoryser">
      	<label>{l s='Selected Category' mod='tomcategorysearch'}</label>
      		<div class="form-group">
      		<select name="allselectedcate[]" id="allselectedcate" class="form-control" multiple>
          {asort($allselcate)|escape:'htmlall':'UTF-8'}
          {foreach $allselcate as $k =>$v}
          {if $v ne ''}
          <option value="{$k|escape:'htmlall':'UTF-8'}"> {$v|escape:'htmlall':'UTF-8'} </option>
          {/if}
          {/foreach}
  
      		</select>
      		</div>
          </form>
      		<button class="btn btn-danger" id="removecategoryl" > {l s='Remove' mod='tomcategorysearch'} </button>
          
      	 </div>

      	 <div class="col-sm-5">  
        
      	 <label>Available Category</label>
      	   <div class="form-group"> 
            <select id="selectcate" name="selectcate" multiple class="form-control">
        {foreach $cats as $k =>$v}
           
             <option value="{$k|escape:'htmlall':'UTF-8'}"> {$v|escape:'htmlall':'UTF-8'} </option>
       
          {/foreach}

            </select>
      	   </div>
      	   <button class="btn btn-info" id="addtocategorylist"> {l s='Add' mod='tomcategorysearch'} </button>

      	 </div>
      	</div>

      </div>
      </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="sfields">
      <form class="" method="POST" action="" id="searchablefform" name="searchablefform">
        <div class="panel panel-info">
        <div class="panel-body">
        <p class="note"> {l s='Fields that are searchable' mod='tomcategorysearch'} </p>
  <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label> {l s='Product Name' mod='tomcategorysearch'}</label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="productname" id="productname_on" {if isset($productname)} {if $productname eq 1} checked {/if} {/if} value="1" type="radio">
            <label for="productname_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="productname" id="productname_off" {if isset($productname)} {if $productname eq 0} checked {/if} {/if} value="0"  type="radio">
            <label for="productname_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

  <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label> {l s='Product Reference' mod='tomcategorysearch'}</label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="productref" id="productref_on" {if isset($productref)} {if $productref eq 1} checked {/if} {/if} value="1" type="radio">
            <label for="productref_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="productref" id="productref_off" {if isset($productref)} {if $productref eq 0} checked {/if} {/if} value="0"  type="radio">
            <label for="productref_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

  <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label> {l s='Product Short Description' mod='tomcategorysearch'}</label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="productshortd" id="productshortd_on" {if isset($productshortd)} {if $productshortd eq 1} checked {/if} {/if} value="1" type="radio">
            <label for="productshortd_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="productshortd" id="productshortd_off" {if isset($productshortd)} {if $productshortd eq 0} checked {/if} {/if} value="0"  type="radio">
            <label for="productshortd_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>


  <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label> {l s='Product Description' mod='tomcategorysearch'}</label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="productdes" id="productdes_on" {if isset($productdes)} {if $productdes eq 1} checked {/if} {/if} value="1" type="radio">
            <label for="productdes_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="productdes" id="productdes_off" {if isset($productdes)} {if $productdes eq 0} checked {/if} {/if} value="0"  type="radio">
            <label for="productdes_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

    <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label> {l s='Product Supplier' mod='tomcategorysearch'}</label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="productsup" id="productsup_on" {if isset($productsup)} {if $productsup eq 1} checked {/if} {/if} value="1" type="radio">
            <label for="productsup_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="productsup" id="productsup_off" {if isset($productsup)} {if $productsup eq 0} checked {/if} {/if} value="0"  type="radio">
            <label for="productsup_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

      <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label> {l s='Product Manufacturer' mod='tomcategorysearch'} </label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="productman" id="productman_on" value="1" {if isset($productman)} {if $productman eq 1} checked {/if} {/if} type="radio">
            <label for="productman_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="productman" id="productman_off" {if isset($productman)} {if $productman eq 0} checked {/if} {/if} value="0"  type="radio">
            <label for="productman_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

        </div> <!-- /panel body -->
        <div class="panel-footer"> 
          <div class="form-group"> 
            <input type="submit" value="Save Settings" class="btn btn-lg btn-info" name="submitsfieldsbtn" id="submitsfieldsbtn">

          </div>

        </div>
        </div>
      </form>



    </div>
    <div role="tabpanel" class="tab-pane" id="displayresult">
    <form class="" method="POST" action="" name="displayablefform" id="displayablefform">
        <div class="panel panel-info">
        <div class="panel-body">
<p> {l s='Fields that can be displayed on the search result' mod='tomcategorysearch'}. </p>

          <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label> {l s='Product Name' mod='tomcategorysearch'} </label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="displayname" id="displayname_on" {if isset($displayname)} {if $displayname eq 1} checked {/if} {/if} value="1" type="radio">
            <label for="displayname_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="displayname" id="displayname_off" {if isset($displayname)} {if $displayname eq 0} checked {/if} {/if} value="0"  type="radio">
            <label for="displayname_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

       <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label> {l s='Product Reference' mod='tomcategorysearch'}</label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="displayreference" id="displayreference_on" {if isset($displayreference)} {if $displayreference eq 1} checked {/if} {/if} value="1" type="radio">
            <label for="displayreference_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="displayreference" id="displayreference_off" {if isset($displayreference)} {if $displayreference eq 0} checked {/if} {/if} value="0"  type="radio">
            <label for="displayreference_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

    <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label>  {l s='Short Description' mod='tomcategorysearch'} </label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="displayshortdes" id="displayshortdes_on" {if isset($displayshortdes)} {if $displayshortdes eq 1} checked {/if} {/if} value="1" type="radio">
            <label for="displayshortdes_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="displayshortdes" id="displayshortdes_off" {if isset($displayshortdes)} {if $displayshortdes eq 0} checked {/if} {/if} value="0"  type="radio">
            <label for="displayshortdes_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

 <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label>  {l s='Product Image' mod='tomcategorysearch'}</label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="displayimage" id="displayimage_on" {if isset($displayimage)} {if $displayimage eq 1} checked {/if} {/if} value="1" type="radio">
            <label for="displayimage_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="displayimage" id="displayimage_off" value="0" {if isset($displayimage)} {if $displayimage eq 0} checked {/if} {/if}  type="radio">
            <label for="displayimage_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

 <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label>  {l s='Price' mod='tomcategorysearch'}</label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="displayprice" id="displayprice_on"{if isset($displayprice)} {if $displayprice eq 1} checked {/if} {/if} value="1" type="radio">
            <label for="displayprice_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="displayprice" id="displayprice_off" {if isset($displayprice)} {if $displayprice eq 0} checked {/if} {/if} value="0"  type="radio">
            <label for="displayprice_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>


 <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label>  {l s='Add to Cart Button' mod='tomcategorysearch'} </label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="displayaddtocartbtn" id="displayaddtocartbtn_on" {if isset($displayaddtocartbtn)} {if $displayaddtocartbtn eq 1} checked {/if} {/if} value="1" type="radio">
            <label for="displayaddtocartbtn_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="displayaddtocartbtn" {if isset($displayaddtocartbtn)} {if $displayaddtocartbtn eq 0} checked {/if} {/if}  id="displayaddtocartbtn_off" value="0"  type="radio">
            <label for="displayaddtocartbtn_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

 <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label> {l s='Supplier' mod='tomcategorysearch'} </label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="displaysup" id="displaysup_on"{if isset($displaysup)} {if $displaysup eq 1} checked {/if} {/if}  value="1" type="radio">
            <label for="displaysup_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="displaysup" id="displaysup_off" {if isset($displaysup)} {if $displaysup eq 0} checked {/if} {/if}  value="0"  type="radio">
            <label for="displaysup_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

   <div class="form-group">
          <div class="row">
          <div class="col-sm-3">
            <label>  {l s='Manufacturer' mod='tomcategorysearch'} </label>
            </div>
            <div class="col-sm-6">
       <span class="switch prestashop-switch fixed-width-lg">
                          
            <input name="displaymanu" id="displaymanu_on"{if isset($displaymanu)} {if $displaymanu eq 1} checked {/if} {/if}  value="1" type="radio">
            <label for="displaymanu_on">{l s='Yes' mod='tomcategorysearch'}</label>
            <input name="displaymanu" id="displaymanu_off"{if isset($displaymanu)} {if $displaymanu eq 0} checked {/if} {/if}  value="0"  type="radio">
            <label for="displaymanu_off">{l s='No' mod='tomcategorysearch'}</label>
            <a class="slide-button btn"></a>
        </span>
        </div>
        </div>
  </div>

<div class="form-group">
<div class="row"> 
<div class="col-sm-3"> 
<label for="instantproductlimit"> {l s='Number of search result' mod='tomcategorysearch'}  </label>
</div>
<div class="col-sm-6">
<input type="text"{literal} pattern="[0-9]{1,3}" {/literal} value="{if isset($instantproductlimit)}{$instantproductlimit|escape:'htmlall':'UTF-8'}{/if}" id="instantproductlimit" name="instantproductlimit" class="form-control">
 </div>

 </div>

</div>
        </div> <!-- / panel body -->

<div class="panel-footer">
  <div class="form-group">
    <input type="submit" id="submitdisplayablebtn" name="submitdisplayablebtn" value="{l s='Save Changes' mod='tomcategorysearch'}" class="btn btn-lg btn-info pull-right">

  </div>

 </div>
        </div>
    </form>

    </div>

    <div role="tabpanel" class="tab-pane" id="showstyles">
      <form class="" method="POST" action="">
      <div class="panel panel-info">
      <div class="panel-body">
          <div class="form-group">

        <div class="row">
        <div class="col-sm-3"> <label for="tcsearchinputdisplay"> {l s='Select Styles' mod='tomcategorysearch'}</label> </div>
        <div class="col-sm-6">  
          <select class="form-control" name="tcsearchinputdisplay">
             <option value="red.css" {if $tcsearchinputdisplay =='red.css'} selected {/if} > {l s='Red & Small' mod='tomcategorysearch'}  </option>

             <option value="red-large.css" {if $tcsearchinputdisplay =='red-large.css'} selected {/if} > {l s='Red & Large display' mod='tomcategorysearch'}  </option>

           

             <option value="blue.css" {if $tcsearchinputdisplay =='blue.css'} selected {/if}> {l s='Blue' mod='tomcategorysearch'}  </option>

            <option value="blue-large.css" {if $tcsearchinputdisplay =='blue-large.css'} selected {/if}> {l s='Blue & Large Display' mod='tomcategorysearch'}  </option>


             <option value="green.css" {if $tcsearchinputdisplay =='green.css'} selected {/if}>{l s='Green' mod='tomcategorysearch'}  </option>

              <option value="green-large.css" {if $tcsearchinputdisplay =='green-large.css'} selected {/if}>{l s='Green & Large Display' mod='tomcategorysearch'}  </option>

      
             <option value="white.css" {if $tcsearchinputdisplay =='white.css'} selected {/if}> {l s='White' mod='tomcategorysearch'} </option>

             <option value="white-large.css" {if $tcsearchinputdisplay =='white-large.css'} selected {/if}> {l s='White & Large Display' mod='tomcategorysearch'} </option>

             <option value="gray.css" {if $tcsearchinputdisplay =='gray.css'} selected {/if}> {l s='Gray' mod='tomcategorysearch'}  </option>

               <option value="gray-large.css" {if $tcsearchinputdisplay =='gray-large.css'} selected {/if}> {l s='Gray & Large Display' mod='tomcategorysearch'}  </option>

             <option value="dark.css" {if $tcsearchinputdisplay =='dark.css'} selected {/if}>{l s='Dark' mod='tomcategorysearch'}  </option>
              <option value="dark-large.css" {if $tcsearchinputdisplay =='dark-large.css'} selected {/if}>{l s='Dark & Large Display' mod='tomcategorysearch'}  </option>

          </select>
        </div>
        </div>

          </div>
       <div class="form-group">

        <div class="row">
        <div class="col-sm-3"> <label for="tcsearchcustomstyle"> {l s='Custom Style (Optional)' mod='tomcategorysearch'}</label> </div>
        <div class="col-sm-6">  
         <textarea name="tcsearchcustomstyle" class="form-control" rows="6">
           {if isset($tcsearchcustomstyle)} {$tcsearchcustomstyle|escape:'htmlall':'UTF-8'}{/if}
         </textarea>
        </div>
        </div>

          </div>

      </div>
      <div class="panel-footer">
          <div class="form-group">
          <input type="submit" value="Save Settings" name="savecustomstylebtn" class="btn btn-lg btn-info pull-right">

          </div>
      </div>
      </div>



      </form>  

    </div>   <!-- /showstyles -->
  </div>

</div>

</div>
</div>
</div>
</div>
<script>
  $(document).ready(function(){
$('#addtocategorylist').on('click', function(){

$('#selectcate :selected').each(function(i, selected){ 
  
  $('#allselectedcate').append('<option value="'+ $(selected).val() + '">'+$(selected).text()+'</option>');
});
});

$('#removecategoryl').on('click', function(){
  $('#allselectedcate :selected').each(function(i, selected){ 
$('#allselectedcate option[value="'+$(selected).val()+'"]').remove();
 });   
});
$('#savecatechanges').on('click',function(){
   $('#allselectedcate option').prop('selected', true);
  $('#allcategoryselectedform').submit();
});
  });

</script>