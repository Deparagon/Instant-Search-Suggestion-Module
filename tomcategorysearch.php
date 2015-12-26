<?php

/**
 * DESCRIPTION.
 *
 * Highly Customizable Instant category search 
 * Powerful search feature that gets specific result faster for easy checkout.
 *
 *  @author    Paragon Kingsley
 *  @copyright 2015 Paragon Kingsley
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License ("AFL") v. 3.0
 */
if (!defined('_PS_VERSION_')) {
    exit;
}

class tomcategorysearch extends Module
{
    public function __construct()
    {
        $this->name = 'tomcategorysearch';
        $this->author = 'Paragon Kingsley';
        $this->version = '1.0.0';
        $this->bootstrap = true;
        $this->tab = 'search_filter';
        $this->need_instance = 0;
        parent::__construct();
        $this->displayName = 'Instant Search product categories';
        $this->description = 'Highly Customizable Instant Search Module';
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
    }
    public function install()
    {
        if (!parent::install() || !$this->registerHook('displayHeader') || !$this->registerHook('displayTop') || !$this->preConfigureSearch() || !$this->disableOtherSearch() || !$this->makeTCSdaFirst()) {
            return false;
        }

        return true;
    }

    public function deleteConfiguredVar()
    {
        Configuration::deleteByName('TCS_PRODUCT_S_NAME');
        Configuration::deleteByName('TCS_PRODUCT_S_REF');
        Configuration::deleteByName('TCS_PRODUCT_S_SHORTD');
        Configuration::deleteByName('TCS_PRODUCT_S_DES');
        Configuration::deleteByName('TCS_PRODUCT_S_SUP');
        Configuration::deleteByName('TCS_PRODUCT_S_MAN');
        Configuration::deleteByName('TCS_DISPLAY_NAME');
        Configuration::deleteByName('TCS_DISPLAY_REF');
        Configuration::deleteByName('TCS_DISPLAY_SHORTDES');
        Configuration::deleteByName('TCS_DISPLAY_IMAGE');
        Configuration::deleteByName('TCS_DISPLAY_PRICE');
        Configuration::deleteByName('TCS_DISPLAY_CARTBTN');
        Configuration::deleteByName('TCS_DISPLAY_SUP');
        Configuration::deleteByName('TCS_DISPLAY_MANU');
        Configuration::deleteByName('ALL_SEARCHABLE_CATE');
        Configuration::deleteByName('TCS_ALL_SEARCHABLE_CATE');
        Configuration::deleteByName('TCS_INSTANT_LIMIT');
        Configuration::deleteByName('TCS_INPUT_SDISPLAY');
        Configuration::deleteByName('TCS_CUSTOM_STYLE');

        return true;
    }
    public function preConfigureSearch()
    {
        Configuration::updateValue('TCS_PRODUCT_S_NAME', 1);
        Configuration::updateValue('TCS_PRODUCT_S_REF', 1);
        Configuration::updateValue('TCS_PRODUCT_S_SHORTD', 1);
        Configuration::updateValue('TCS_PRODUCT_S_DES', 1);
        Configuration::updateValue('TCS_PRODUCT_S_SUP', 0);
        Configuration::updateValue('TCS_PRODUCT_S_MAN', 0);
        Configuration::updateValue('TCS_DISPLAY_NAME', 1);
        Configuration::updateValue('TCS_DISPLAY_REF', 0);
        Configuration::updateValue('TCS_DISPLAY_SHORTDES', 0);
        Configuration::updateValue('TCS_DISPLAY_IMAGE', 1);
        Configuration::updateValue('TCS_DISPLAY_PRICE', 1);
        Configuration::updateValue('TCS_DISPLAY_CARTBTN', 0);
        Configuration::updateValue('TCS_DISPLAY_SUP', 0);
        Configuration::updateValue('TCS_DISPLAY_MANU', 0);
        Configuration::updateValue('TCS_INSTANT_LIMIT', 5);
        Configuration::updateValue('TCS_INPUT_SDISPLAY', 'white.css');
        Configuration::updateValue('TCS_CUSTOM_STYLE', '');

        return true;
    }
    public function uninstall()
    {
        if (!parent::uninstall() || !$this->deleteConfiguredVar()) {
            return false;
        }

        return true;
    }

    public function getShopCategory()
    {
        $sql = 'SELECT '._DB_PREFIX_.'category.id_category, name FROM '._DB_PREFIX_.'category INNER JOIN '._DB_PREFIX_.'category_lang ON '._DB_PREFIX_.'category_lang.id_category = '._DB_PREFIX_.'category.id_category WHERE active =1 AND id_shop ='.(int) $this->context->shop->id.' AND id_lang ='.(int) Context::getContext()->language->id;
        $data = array();
        $result = Db::getInstance()->executeS($sql);
        foreach ($result as $key => $value) {
            //echo $value['id_category'].' : '.$value['name'];
            $data[$value['id_category']] = $value['name'];
        }

        return $data;
    }
    public function getContent()
    {
        $this->context->controller->addCSS(_PS_MODULE_DIR_.$this->name.'/views/css/getcontent.css');
        $this->processSearchableField();
        $this->processDisplayableFields();
        $this->processAddedStyle();
        $this->getSaveOptionsCate();
        $this->assignVarToSmarty();
        $this->assignSmartyVarCate();
        $this->context->smarty->assign('cats', $this->getShopCategory());

        return $this->display(__FILE__, 'getContent.tpl');
    }

    public function assignVarToSmarty()
    {
        $this->context->smarty->assign(array(
                'displayname' => Configuration::get('TCS_DISPLAY_NAME'),
                'displayreference' => Configuration::get('TCS_DISPLAY_REF'),
                'displayshortdes' => Configuration::get('TCS_DISPLAY_SHORTDES'),
                'displayimage' => Configuration::get('TCS_DISPLAY_IMAGE'),
                'displayprice' => Configuration::get('TCS_DISPLAY_PRICE'),
                'displayaddtocartbtn' => Configuration::get('TCS_DISPLAY_CARTBTN'),
                'displaysup' => Configuration::get('TCS_DISPLAY_SUP'),
                'displaymanu' => Configuration::get('TCS_DISPLAY_MANU'),
                  'ok' => 'ok',

                ));

        $this->context->smarty->assign(array(
                            'productname' => Configuration::get('TCS_PRODUCT_S_NAME'),
                            'productref' => Configuration::get('TCS_PRODUCT_S_REF'),
                            'productshortd' => Configuration::get('TCS_PRODUCT_S_SHORTD'),
                            'productdes' => Configuration::get('TCS_PRODUCT_S_DES'),
                            'productsup' => Configuration::get('TCS_PRODUCT_S_SUP'),
                            'productman' => Configuration::get('TCS_PRODUCT_S_MAN'),
                            'instantproductlimit' => Configuration::get('TCS_INSTANT_LIMIT'),

));

        $this->context->smarty->assign(array(
                    'tcsearchinputdisplay' => Configuration::get('TCS_INPUT_SDISPLAY'),
                    'tcsearchcustomstyle' => Configuration::get('TCS_CUSTOM_STYLE'),

            ));
    }
    public function assignSmartyVarCate()
    {
        $cate = Tools::jsonDecode(Configuration::get('TCS_ALL_SEARCHABLE_CATE'));
        if (!empty($cate)) {
            $searchcat = array();
            foreach ($cate as $cat) {
                $searchcat[$cat] = $this->getCatName($cat);
            }
            // print_r($searchcat);
            $this->context->smarty->assign('allselcate', $searchcat);
        }
    }

    public function processSearchableField()
    {
        if (Tools::isSubmit('submitsfieldsbtn')) {
            Configuration::updateValue('TCS_PRODUCT_S_NAME', (int) Tools::getValue('productname'));
            Configuration::updateValue('TCS_PRODUCT_S_REF', (int) Tools::getValue('productref'));
            Configuration::updateValue('TCS_PRODUCT_S_SHORTD', (int) Tools::getValue('productshortd'));
            Configuration::updateValue('TCS_PRODUCT_S_DES', (int) Tools::getValue('productdes'));
            Configuration::updateValue('TCS_PRODUCT_S_SUP', (int) Tools::getValue('productsup'));
            Configuration::updateValue('TCS_PRODUCT_S_MAN', (int) Tools::getValue('productman'));
            Configuration::updateValue('TCS_INSTANT_LIMIT', (int) Tools::getValue('instantproductlimit'));
        }
    }

    public function processDisplayableFields()
    {
        if (Tools::isSubmit('submitdisplayablebtn')) {
            Configuration::updateValue('TCS_DISPLAY_NAME', (int) Tools::getValue('displayname'));
            Configuration::updateValue('TCS_DISPLAY_REF', (int) Tools::getValue('displayreference'));
            Configuration::updateValue('TCS_DISPLAY_SHORTDES', (int) Tools::getValue('displayshortdes'));
            Configuration::updateValue('TCS_DISPLAY_IMAGE', (int) Tools::getValue('displayimage'));
            Configuration::updateValue('TCS_DISPLAY_PRICE', (int) Tools::getValue('displayprice'));
            Configuration::updateValue('TCS_DISPLAY_CARTBTN', (int) Tools::getValue('displayaddtocartbtn'));
            Configuration::updateValue('TCS_DISPLAY_SUP', (int) Tools::getValue('displaysup'));
            Configuration::updateValue('TCS_DISPLAY_MANU', (int) Tools::getValue('displaymanu'));
        }
    }

    public function processAddedStyle()
    {
        if (Tools::isSubmit('savecustomstylebtn')) {
            Configuration::updateValue('TCS_INPUT_SDISPLAY', Tools::getValue('tcsearchinputdisplay'));

            if (Tools::getValue('tcsearchcustomstyle') != '') {
                $customstyle = dirname(__FILE__).'/views/css/tcs.custom.css';

                file_put_contents($customstyle, Tools::getValue('tcsearchcustomstyle'));
                Configuration::updateValue('TCS_CUSTOM_STYLE', Tools::getValue('tcsearchcustomstyle'));
            }
        }
    }
    public function getSaveOptionsCate()
    {
        if (Tools::getIsset('thiwcategoryser')) {
            $cat = array();
            if (Tools::getValue('thiwcategoryser') == 'igetmeseavedatcate') {
                foreach ((Tools::getValue('allselectedcate')) as $data) {
                    $cat[] = $data;
                }
                Configuration::updateValue('TCS_ALL_SEARCHABLE_CATE', Tools::jsonEncode($cat));
                //$this->assignSmartyVarCate();
            }
        }
    }
    public function getCatName($id)
    {
        $sql = 'SELECT name FROM '._DB_PREFIX_.'category_lang WHERE id_lang='.(int) Context::getContext()->language->id.' AND id_category ='.(int) $id;

        return Db::getInstance()->getValue($sql);
    }

    public function hookDisplayTop()
    {
        $this->context->controller->addCSS(_PS_MODULE_DIR_.$this->name.'/views/css/'.Configuration::get('TCS_INPUT_SDISPLAY'));
        $this->context->controller->addCSS(_PS_MODULE_DIR_.$this->name.'/views/css/tcs_custom.css');

        $this->assignSmartyVarCate();

        return $this->display(__FILE__, 'searchTop.tpl');
    }
    public function makeTCSdaFirst()
    {
        $id_hook = Hook::getIdByName('displayTop');

        return Db::getInstance()->update('hook_module', array('position' => 1), ' id_module ='.(int) $this->id.' AND id_hook='.(int) $id_hook.' AND id_shop ='.$this->context->shop->id);
    }

    public function disableOtherSearch()
    {
        if (Module::isEnabled('blocksearch')) {
            Module::disableByName('blocksearch');
        }
        if (Module::isEnabled('searchsuggestions')) {
            Module::disableByName('searchsuggestions');
        }
        if (Module::isEnabled('powersearch')) {
            Module::disableByName('powersearch');
        }

        return true;
    }

    public function hookdisplayMobileTopSiteMap($params)
    {
        return $this->hookDisplayTop($params);
    }

    public function hookDisplayLeftColumn()
    {
        $this->context->controller->addCSS(_PS_MODULE_DIR_.$this->name.'/views/css/'.Configuration::get('TCS_INPUT_SDISPLAY'));
        $this->context->controller->addCSS(_PS_MODULE_DIR_.$this->name.'/views/css/tcsearch.css');
        $this->context->controller->addCSS(_PS_MODULE_DIR_.$this->name.'/views/css/tcs_custom.css');

        $this->assignSmartyVarCate();

        return $this->display(__FILE__, 'columnSearch.tpl');
    }

    public function hookDisplayRightColumn()
    {
        return $this->hookDisplayLeftColumn();
    }
    public function hookDisplayNav($params)
    {
        return $this->hookDisplayTop($params);
    }
}
