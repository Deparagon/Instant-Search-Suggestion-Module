<?php

/**
 * DESCRIPTION.
 *
 * Highly Customizable Instant category search 
 * Powerful search feature that extends the default prestashop search.
 *
 *  @author    Paragon Kingsley
 *  @copyright 2015 Paragon Kingsley
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License ("AFL") v. 3.0
 */
if (!defined('_PS_VERSION_')) {
    exit;
}

require_once dirname(__FILE__).'/../../classes/BaseSearcher.php';
class TomcategorySearchResponderModuleFrontController extends ModuleFrontController
{
    public $idcate;
    public $searchtext;
    public $mod;
    public function postProcess()
    {
        parent::postProcess();
        if (Tools::getIsset('token')) {
            if (Tools::getValue('token') == 'tiskwoalea') {
                $this->mod = Module::getInstanceByName('tomcategorysearch');
                if (Tools::getValue('tcsearchdata') != '') {
                    $this->idcate = Tools::getValue('sfcategory');
                    $this->searchtext = Tools::getValue('tcsearchdata');
                    $this->searchProductTable();
                } else {
                    echo 'Nothing found';
                    exit;
                }
            }
        }
       // print_r($_POST);
        //exit;
    }

    public function searchProductTable()
    {
        $result = BaseSearcher::doSearchProducts($this->searchtext, $this->idcate, $this->context->cookie->id_lang);
        if (!empty($result)) {
            $i = 0;
            foreach ($result as $product) {
                if ($i == ((int) Configuration::get('TCS_INSTANT_LIMIT'))) {
                    break;
                }
                $newproduct = new Product((int) $product['id_product'], true, $this->context->cookie->id_lang);
                if (Validate::isLoadedObject($newproduct)) {
                    //print_r($newproduct);
                    $id_image = Product::getCover($newproduct->id);
            // get Image by id
            if (sizeof($id_image) > 0) {
                $image = new Image($id_image['id_image']);
             // get image full URL
                $image_url = _PS_BASE_URL_._THEME_PROD_DIR_.$image->getExistingImgPath().'.jpg';
            }
                    $link = new Link();
                    $productlink = $link->getProductLink($newproduct);

                    ?>
<div id="product-box">
      <div class="thumbnail imagebo">
    <?php if (Configuration::get('TCS_DISPLAY_IMAGE') == 1) {
    ?> 
    <a href="<?php echo $productlink;
    ?>"> 
      <img class="img-responsive p-box-img" src="<?php echo $image_url;
    ?>">
    </a>
 <?php 
}
                    ?>

      <div class="caption">
       <?php if (Configuration::get('TCS_DISPLAY_NAME') == 1) {
    ?> 
        <h3 class="product-name">    <a href="<?php echo $productlink;
    ?>"> <?php echo $newproduct->name;
    ?> </a></h3>
 <?php 
}
                    ?>
 <?php if (Configuration::get('TCS_DISPLAY_REF') == 1) {
    ?> 
<h4 class="product-ref"> <?php echo $newproduct->reference;
    ?> </h4>
   <?php 
}
                    ?>

  <?php if (Configuration::get('TCS_DISPLAY_SHORTDES') == 1) {
    ?> 
        <p class="product-desc"> <?php echo $newproduct->description_short;
    ?> </p>

 <?php 
}
                    ?>
 <?php if (Configuration::get('TCS_DISPLAY_MANU') == 1) {
    ?> 
        <p class="product-man"> Manufacture: <span> <?php echo $newproduct->manufacturer_name;
    ?> </span> </p>
<?php 
}
                    ?>
<?php if (Configuration::get('TCS_DISPLAY_SUP') == 1) {
    ?>                  
        <p class="product-sup"> Supplier: <span> <?php echo $newproduct->supplier_name;
    ?> </span> </p>
         <?php 
}
                    ?>     
   <?php if (Configuration::get('TCS_DISPLAY_PRICE') == 1) {
    ?>              
        <p class="product-price"> <?php echo Tools::displayPrice($newproduct->price);
    ?> </p>
             <?php 
}
                    ?> 
             
  <?php if (Configuration::get('TCS_DISPLAY_CARTBTN') == 1) {
    ?>    
    <p class="cart-box"><a data-minimal_quantity="1" data-id-product="<?php echo $newproduct->id;
    ?>" title="<?php echo $this->mod->l('Add to cart');
    ?>" rel="nofollow" href="<?php echo $this->context->link->getPageLink('cart');
    ?>?qty=1&id_product=<?php echo $newproduct->id;
    ?>" class="button ajax_add_to_cart_button btn btn-default">
                    <span> <?php echo $this->mod->l('Add to cart');
    ?> </span>
                </a></p>
  <?php 
}
                    ?> 
   
      </div>
    </div>

      </div>

<?php

                }
               // }
                ++$i;
            }
            // print_r($result);
            exit;
        } else {
            echo '<div id="product-box"> No product found </div>';
            exit;
        }
    }
}
