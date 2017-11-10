<?php
/*
 * If you have a charset warning, or problems displaying filenames with accented characters,
 * check your system locale and set it in the form lang_country.charset
 * Example : fr_FR.UTF-8, fr_FR.ISO-8859-1, fr_FR.CP1252 (windows), en_EN.UTF-8, etc.
 *
 * Windows users may define an empty string
 * define("AJXP_LOCALE", "");
 */
define("AJXP_LOCALE", "PYDIO_LOCALE.UTF-8");

/*
 * If you want to force the https, uncomment the line below. This will automatically
 * redirect all calls to ajaxplorer via http to the same URL with https
 */
define("AJXP_FORCE_SSL_REDIRECT", PYDIO_FORCE_HTTPS);

/*
 * Configure data path
 */
define("AJXP_DATA_PATH", "/data/pydio");

/*
 * Configure temporary directory
 */
define("AJXP_TMP_DIR", AJXP_DATA_PATH."/tmp");
