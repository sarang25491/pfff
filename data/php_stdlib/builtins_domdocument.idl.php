<?php
// THIS IS AUTOGENERATED BY builtins_php.ml
function dom_document_create_element($obj, $name, $value = null_string) { }
function dom_document_create_document_fragment($obj) { }
function dom_document_create_text_node($obj, $data) { }
function dom_document_create_comment($obj, $data) { }
function dom_document_create_cdatasection($obj, $data) { }
function dom_document_create_processing_instruction($obj, $target, $data = null_string) { }
function dom_document_create_attribute($obj, $name) { }
function dom_document_create_entity_reference($obj, $name) { }
function dom_document_get_elements_by_tag_name($obj, $name) { }
function dom_document_import_node($obj, $importednode, $deep = false) { }
function dom_document_create_element_ns($obj, $namespaceuri, $qualifiedname, $value = null_string) { }
function dom_document_create_attribute_ns($obj, $namespaceuri, $qualifiedname) { }
function dom_document_get_elements_by_tag_name_ns($obj, $namespaceuri, $localname) { }
function dom_document_get_element_by_id($obj, $elementid) { }
function dom_document_normalize_document($obj) { }
function dom_document_save($obj, $file, $options = 0) { }
function dom_document_savexml($obj, $node = null_object, $options = 0) { }
function dom_document_validate($obj) { }
function dom_document_xinclude($obj, $options = 0) { }
function dom_document_save_html($obj) { }
function dom_document_save_html_file($obj, $file) { }
function dom_document_schema_validate_file($obj, $filename) { }
function dom_document_schema_validate_xml($obj, $source) { }
function dom_document_relaxng_validate_file($obj, $filename) { }
function dom_document_relaxng_validate_xml($obj, $source) { }
function dom_node_insert_before($obj, $newnode, $refnode = null) { }
function dom_node_replace_child($obj, $newchildobj, $oldchildobj) { }
function dom_node_remove_child($obj, $node) { }
function dom_node_append_child($obj, $newnode) { }
function dom_node_has_child_nodes($obj) { }
function dom_node_clone_node($obj, $deep = false) { }
function dom_node_normalize($obj) { }
function dom_node_is_supported($obj, $feature, $version) { }
function dom_node_has_attributes($obj) { }
function dom_node_is_same_node($obj, $node) { }
function dom_node_lookup_prefix($obj, $prefix) { }
function dom_node_is_default_namespace($obj, $namespaceuri) { }
function dom_node_lookup_namespace_uri($obj, $namespaceuri) { }
function dom_nodelist_item($obj, $index) { }
function dom_namednodemap_get_named_item($obj, $name) { }
function dom_namednodemap_item($obj, $index) { }
function dom_namednodemap_get_named_item_ns($obj, $namespaceuri, $localname) { }
function dom_characterdata_substring_data($obj, $offset, $count) { }
function dom_characterdata_append_data($obj, $arg) { }
function dom_characterdata_insert_data($obj, $offset, $data) { }
function dom_characterdata_delete_data($obj, $offset, $count) { }
function dom_characterdata_replace_data($obj, $offset, $count, $data) { }
function dom_attr_is_id($obj) { }
function dom_element_get_attribute($obj, $name) { }
function dom_element_set_attribute($obj, $name, $value) { }
function dom_element_remove_attribute($obj, $name) { }
function dom_element_get_attribute_node($obj, $name) { }
function dom_element_set_attribute_node($obj, $newattr) { }
function dom_element_remove_attribute_node($obj, $oldattr) { }
function dom_element_get_elements_by_tag_name($obj, $name) { }
function dom_element_get_attribute_ns($obj, $namespaceuri, $localname) { }
function dom_element_set_attribute_ns($obj, $namespaceuri, $name, $value) { }
function dom_element_remove_attribute_ns($obj, $namespaceuri, $localname) { }
function dom_element_get_attribute_node_ns($obj, $namespaceuri, $localname) { }
function dom_element_set_attribute_node_ns($obj, $newattr) { }
function dom_element_get_elements_by_tag_name_ns($obj, $namespaceuri, $localname) { }
function dom_element_has_attribute($obj, $name) { }
function dom_element_has_attribute_ns($obj, $namespaceuri, $localname) { }
function dom_element_set_id_attribute($obj, $name, $isid) { }
function dom_element_set_id_attribute_ns($obj, $namespaceuri, $localname, $isid) { }
function dom_element_set_id_attribute_node($obj, $idattr, $isid) { }
function dom_text_split_text($obj, $offset) { }
function dom_text_is_whitespace_in_element_content($obj) { }
function dom_xpath_register_ns($obj, $prefix, $uri) { }
function dom_xpath_query($obj, $expr, $context = null_object) { }
function dom_xpath_evaluate($obj, $expr, $context = null_object) { }
function dom_xpath_register_php_functions($obj, $funcs = null) { }
class DOMNode {
 function __construct() { }
 function appendChild($newnode) { }
 function cloneNode($deep = false) { }
 function getLineNo() { }
 function hasAttributes() { }
 function hasChildNodes() { }
 function insertBefore($newnode, $refnode = null) { }
 function isDefaultNamespace($namespaceuri) { }
 function isSameNode($node) { }
 function isSupported($feature, $version) { }
 function lookupNamespaceUri($namespaceuri) { }
 function lookupPrefix($prefix) { }
 function normalize() { }
 function removeChild($node) { }
 function replaceChild($newchildobj, $oldchildobj) { }
 function c14n($exclusive = false, $with_comments = false, $xpath = null, $ns_prefixes = null) { }
 function c14nfile($uri, $exclusive = false, $with_comments = false, $xpath = null, $ns_prefixes = null) { }
 function getNodePath() { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function __destruct() { }
}
class DOMAttr {
 function __construct($name, $value = null_string) { }
 function isId() { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function __destruct() { }
}
class DOMCharacterData {
 function __construct() { }
 function appendData($arg) { }
 function deleteData($offset, $count) { }
 function insertData($offset, $data) { }
 function replaceData($offset, $count, $data) { }
 function substringData($offset, $count) { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function __destruct() { }
}
class DOMComment {
 function __construct($value = null_string) { }
 function __destruct() { }
}
class DOMText {
 function __construct($value = null_string) { }
 function isWhitespaceInElementContent() { }
 function splitText($offset) { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function __destruct() { }
}
class DOMCDATASection {
 function __construct($value) { }
 function __destruct() { }
}
class DOMDocument {
 function __construct($version = null_string, $encoding = null_string) { }
 function createAttribute($name) { }
 function createAttributens($namespaceuri, $qualifiedname) { }
 function createCDATASection($data) { }
 function createComment($data) { }
 function createDocumentFragment() { }
 function createElement($name, $value = null_string) { }
 function createElementNS($namespaceuri, $qualifiedname, $value = null_string) { }
 function createEntityReference($name) { }
 function createProcessingInstruction($target, $data = null_string) { }
 function createTextNode($data) { }
 function getElementById($elementid) { }
 function getElementsByTagName($name) { }
 function getElementsByTagNameNS($namespaceuri, $localname) { }
 function importNode($importednode, $deep = false) { }
 function load($filename, $options = 0) { }
 function loadHTML($source) { }
 function loadHTMLFile($filename) { }
 function loadXML($source, $options = 0) { }
 function normalizeDocument() { }
 function registerNodeClass($baseclass, $extendedclass) { }
 function relaxNGValidate($filename) { }
 function relaxNGValidateSource($source) { }
 function save($file, $options = 0) { }
 function saveHTML() { }
 function saveHTMLFile($file) { }
 function saveXML($node = null_object, $options = 0) { }
 function schemaValidate($filename) { }
 function schemaValidateSource($source) { }
 function validate() { }
 function xinclude($options = 0) { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function __destruct() { }
}
class DOMDocumentFragment {
 function __construct() { }
 function appendXML($data) { }
 function __destruct() { }
}
class DOMDocumentType {
 function __construct() { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function __destruct() { }
}
class DOMElement {
 function __construct($name, $value = null_string, $namespaceuri = null_string) { }
 function getAttribute($name) { }
 function getAttributeNode($name) { }
 function getAttributeNodeNS($namespaceuri, $localname) { }
 function getAttributeNS($namespaceuri, $localname) { }
 function getElementsByTagName($name) { }
 function getElementsByTagNameNS($namespaceuri, $localname) { }
 function hasAttribute($name) { }
 function hasAttributeNS($namespaceuri, $localname) { }
 function removeAttribute($name) { }
 function removeAttributeNode($oldattr) { }
 function removeAttributeNS($namespaceuri, $localname) { }
 function setAttribute($name, $value) { }
 function setAttributeNode($newattr) { }
 function setAttributeNodeNS($newattr) { }
 function setAttributeNS($namespaceuri, $name, $value) { }
 function setIDAttribute($name, $isid) { }
 function setIDAttributeNode($idattr, $isid) { }
 function setIDAttributeNS($namespaceuri, $localname, $isid) { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function __destruct() { }
}
class DOMEntity {
 function __construct() { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function __destruct() { }
}
class DOMEntityReference {
 function __construct($name) { }
 function __destruct() { }
}
class DOMNotation {
 function __construct() { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function __destruct() { }
}
class DOMProcessingInstruction {
 function __construct($name, $value = null_string) { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function __destruct() { }
}
class DOMNodeIterator {
 function __construct() { }
 function current() { }
 function key() { }
 function next() { }
 function rewind() { }
 function valid() { }
 function __destruct() { }
}
class DOMNamedNodeMap {
 function __construct() { }
 function getNamedItem($name) { }
 function getNamedItemNS($namespaceuri, $localname) { }
 function item($index) { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function getIterator() { }
 function __destruct() { }
}
class DOMNodeList {
 function __construct() { }
 function item($index) { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function getIterator() { }
 function __destruct() { }
}
class DOMException {
 function __construct($message = "", $code = 0) { }
 function __destruct() { }
}
class DOMImplementation {
 function __construct() { }
 function createDocument($namespaceuri = null_string, $qualifiedname = null_string, $doctypeobj = null_object) { }
 function createDocumentType($qualifiedname = null_string, $publicid = null_string, $systemid = null_string) { }
 function hasFeature($feature, $version) { }
 function __destruct() { }
}
class DOMXPath {
 function __construct($doc) { }
 function evaluate($expr, $context = null_object) { }
 function query($expr, $context = null_object) { }
 function registerNamespace($prefix, $uri) { }
 function registerPHPFunctions($funcs = null) { }
 function __get($name) { }
 function __set($name, $value) { }
 function __isset($name) { }
 function __destruct() { }
}
