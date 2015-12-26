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

class BaseSearcher
{
    public static function doSearchProducts($searchtext, $idcate, $idlang)
    {
        $sql = 'SELECT '._DB_PREFIX_.'product_lang.id_product FROM '._DB_PREFIX_.'product_lang INNER JOIN '._DB_PREFIX_.'product ON '._DB_PREFIX_.'product.id_product = '._DB_PREFIX_.'product_lang.id_product WHERE (';
        if (Configuration::get('TCS_PRODUCT_S_NAME') == 1) {
            $sql .= ' name LIKE '.'"%'.pSQL($searchtext).'%"';
        }
        if (Configuration::get('TCS_PRODUCT_S_REF') == 1) {
            $sql .= (Configuration::get('TCS_PRODUCT_S_NAME') == 1) ? ' OR reference LIKE '.'"%'.pSQL($searchtext).'%"' : 'reference LIKE '.'"%'.pSQL($searchtext).'%"';
        }
        if (Configuration::get('TCS_PRODUCT_S_SHORTD') == 1) {
            $sql .= ((Configuration::get('TCS_PRODUCT_S_NAME') == 1) or (Configuration::get('TCS_PRODUCT_S_REF') == 1)) ? ' OR description_short LIKE  '.'"%'.pSQL($searchtext).'%"' : 'description_short LIKE  '.'"%'.pSQL($searchtext).'%"';
        }
        if (Configuration::get('TCS_PRODUCT_S_DES') == 1) {
            $sql .= ((Configuration::get('TCS_PRODUCT_S_NAME') == 1) or (Configuration::get('TCS_PRODUCT_S_REF') == 1) or (Configuration::get('TCS_PRODUCT_S_SHORTD') == 1)) ? ' OR description LIKE '.'"%'.pSQL($searchtext).'%"' : 'description LIKE '.'"%'.pSQL($searchtext).'%"';
        }
        $sql .= ' ) AND id_lang ='.(int) $idlang;
        if ($idcate != 'All') {
            $sql .= ' AND id_category_default ='.(int) $idcate;
        }
        if ((Configuration::get('TCS_PRODUCT_S_SUP') == 1)) {
            if ((Configuration::get('TCS_PRODUCT_S_NAME') == 1) or (Configuration::get('TCS_PRODUCT_S_SHORTD')) or (Configuration::get('TCS_PRODUCT_S_REF') == 1) or (Configuration::get('TCS_PRODUCT_S_DES') == 1)) {
                $sql .= ' UNION SELECT '._DB_PREFIX_.'product_lang.id_product FROM '._DB_PREFIX_.'product INNER JOIN '._DB_PREFIX_.'product_lang ON '._DB_PREFIX_.'product_lang.id_product = '._DB_PREFIX_.'product.id_product INNER JOIN '._DB_PREFIX_.'supplier ON '._DB_PREFIX_.'supplier.id_supplier = '._DB_PREFIX_.'product.id_supplier WHERE '._DB_PREFIX_.'supplier.name LIKE '.'"%'.pSQL($searchtext).'%"';
            } else {
                $sql = 'SELECT '._DB_PREFIX_.'product_lang.id_product FROM '._DB_PREFIX_.'product INNER JOIN '._DB_PREFIX_.'product_lang ON '._DB_PREFIX_.'product_lang.id_product = '._DB_PREFIX_.'product.id_product INNER JOIN '._DB_PREFIX_.'supplier ON '._DB_PREFIX_.'supplier.id_supplier = '._DB_PREFIX_.'product.id_supplier WHERE '._DB_PREFIX_.'supplier.name LIKE '.'"%'.pSQL($searchtext).'%"';
            }
        }

        if (Configuration::get('TCS_PRODUCT_S_MAN') == 1) {
            if ((Configuration::get('TCS_PRODUCT_S_NAME') == 1) or (Configuration::get('TCS_PRODUCT_S_REF') == 1) or (Configuration::get('TCS_PRODUCT_S_SHORTD') == 1) or (Configuration::get('TCS_PRODUCT_S_DES') == 1) or (Configuration::get('TCS_PRODUCT_S_SUP') == 1)) {
                $sql .= ' UNION SELECT '._DB_PREFIX_.'product_lang.id_product FROM '._DB_PREFIX_.'product INNER JOIN '._DB_PREFIX_.'product_lang ON '._DB_PREFIX_.'product_lang.id_product = '._DB_PREFIX_.'product.id_product INNER JOIN '._DB_PREFIX_.'manufacturer ON '._DB_PREFIX_.'manufacturer.id_manufacturer = '._DB_PREFIX_.'product.id_manufacturer WHERE '._DB_PREFIX_.'manufacturer.name LIKE '.'"%'.pSQL($searchtext).'%"';
            } else {
                $sql = 'SELECT '._DB_PREFIX_.'product_lang.id_product FROM '._DB_PREFIX_.'product INNER JOIN '._DB_PREFIX_.'product_lang ON '._DB_PREFIX_.'product_lang.id_product = '._DB_PREFIX_.'product.id_product INNER JOIN '._DB_PREFIX_.'manufacturer ON '._DB_PREFIX_.'manufacturer.id_manufacturer = '._DB_PREFIX_.'product.id_manufacturer WHERE '._DB_PREFIX_.'manufacturer.name LIKE '.'"%'.pSQL($searchtext).'%"';
            }
        }

        return Db::getInstance()->executeS($sql);
    }
}
