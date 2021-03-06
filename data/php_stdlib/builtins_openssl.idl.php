<?php
// THIS IS AUTOGENERATED BY builtins_php.ml
function openssl_csr_export_to_file($csr, $outfilename, $notext = true) { }
function openssl_csr_export($csr, &$out, $notext = true) { }
function openssl_csr_get_public_key($csr) { }
function openssl_csr_get_subject($csr, $use_shortnames = true) { }
function openssl_csr_new($dn, &$privkey, $configargs = null_variant, $extraattribs = null_variant) { }
function openssl_csr_sign($csr, $cacert, $priv_key, $days, $configargs = null_variant, $serial = 0) { }
function openssl_error_string() { }
function openssl_open($sealed_data, &$open_data, $env_key, $priv_key_id) { }
function openssl_pkcs12_export_to_file($x509, $filename, $priv_key, $pass, $args = null_variant) { }
function openssl_pkcs12_export($x509, &$out, $priv_key, $pass, $args = null_variant) { }
function openssl_pkcs12_read($pkcs12, &$certs, $pass) { }
function openssl_pkcs7_decrypt($infilename, $outfilename, $recipcert, $recipkey = null_variant) { }
function openssl_pkcs7_encrypt($infilename, $outfilename, $recipcerts, $headers, $flags = 0, $cipherid = k_OPENSSL_CIPHER_RC2_40) { }
function openssl_pkcs7_sign($infilename, $outfilename, $signcert, $privkey, $headers, $flags = k_PKCS7_DETACHED, $extracerts = null_string) { }
function openssl_pkcs7_verify($filename, $flags, $outfilename = null_string, $cainfo = null_array, $extracerts = null_string, $content = null_string) { }
function openssl_pkey_export_to_file($key, $outfilename, $passphrase = null_string, $configargs = null_variant) { }
function openssl_pkey_export($key, &$out, $passphrase = null_string, $configargs = null_variant) { }
function openssl_pkey_free($key) { }
function openssl_free_key($key) { }
function openssl_pkey_get_details($key) { }
function openssl_pkey_get_private($key, $passphrase = null_string) { }
function openssl_get_privatekey($key, $passphrase = null_string) { }
function openssl_pkey_get_public($certificate) { }
function openssl_get_publickey($certificate) { }
function openssl_pkey_new($configargs = null_variant) { }
function openssl_private_decrypt($data, &$decrypted, $key, $padding = k_OPENSSL_PKCS1_PADDING) { }
function openssl_private_encrypt($data, &$crypted, $key, $padding = k_OPENSSL_PKCS1_PADDING) { }
function openssl_public_decrypt($data, &$decrypted, $key, $padding = k_OPENSSL_PKCS1_PADDING) { }
function openssl_public_encrypt($data, &$crypted, $key, $padding = k_OPENSSL_PKCS1_PADDING) { }
function openssl_seal($data, &$sealed_data, &$env_keys, $pub_key_ids) { }
function openssl_sign($data, &$signature, $priv_key_id, $signature_alg = k_OPENSSL_ALGO_SHA1) { }
function openssl_verify($data, $signature, $pub_key_id, $signature_alg = k_OPENSSL_ALGO_SHA1) { }
function openssl_x509_check_private_key($cert, $key) { }
function openssl_x509_checkpurpose($x509cert, $purpose, $cainfo = null_array, $untrustedfile = null_string) { }
function openssl_x509_export_to_file($x509, $outfilename, $notext = true) { }
function openssl_x509_export($x509, &$output, $notext = true) { }
function openssl_x509_free($x509cert) { }
function openssl_x509_parse($x509cert, $shortnames = true) { }
function openssl_x509_read($x509certdata) { }
function openssl_random_pseudo_bytes($length, &$crypto_strong = false) { }
function openssl_cipher_iv_length($method) { }
function openssl_encrypt($data, $method, $password, $raw_output = false, $iv = null_string) { }
function openssl_decrypt($data, $method, $password, $raw_input = false, $iv = null_string) { }
