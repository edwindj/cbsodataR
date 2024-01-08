# cbsodataR 1.0.1

* fixed example in `cbs_get_catalogs`, which failed when catalog was temporarily 
not available.

* bumped version number to 1.0.0 (it's very stable)

* added functions for using maps with `cbsodataR`: `cbs_get_maps`, 
`cbs_join_sf_with_data` and`cbs_get_sf`.

# version 0.5.2

*  fixed issue #29 with retrieving from dataderden.cbs.nl, thanks to Mirjam Zengers for reporting

# version 0.5.0

* added `cbs_search` facility, to search for publications containing words.

* removed internal `setwd()` call, fix for issue #28, thx to @jeroenadema 

* added support for other catalogs: 

        - `cbs_get_catalogs` and `cbs_get_datasets`
        - `cbs_get_data` and `cbs_get_meta` and the like now have a `catalog` argument

# version 0.4.2

* added weeks to cbs_add_date_column, issue #25, thanks to @RichardFromHolland 
* added warnings when filter selection contains invalid keys.
* `<column> = has_substring(<ss>) | "value"` is now allowed.

# version 0.4.1

* added extra query operators: `eq`, `has_substring` and `|` to support the query syntax of cbsopendata.

* updated documentation

# version 0.3.5

* fixed an issue with the vignette, which was failing when the webservice was offline

# version 0.3.4

* updated documentation

* fixed issue #22 when table has no DefaultSelection, thanks to @sarahouweling.

# version 0.3.2

* Added a new function cbs_get_data_from_link to allow for retrieving data using a link created with the opendata portal. Thanks to Albert Pieters for the suggestion

* Improved the base_url default value.

* fixed a bug in cbs_get_data, key columns were not always loaded as character columns (issue #15). Thanks 
to @VincentKars

# version 0.3.1

* removed httr and changed to jsonlite::read_json. httr gave problems with some Windows configurations.

* fixed cbs_get_toc with select argument (issue #12). Thanks to Rob van Harrevelt.

# version 0.3

* changed api: all (new) functions are prefixed with `cbs_` to have a more clean programming interface. 

* old functions are still available and working but are deprecated.

* `verbose=FALSE` and `cache=TRUE` by default: (for new functions).

* `get_table_list` renamed to `cbs_get_toc`

* data by default is `typed`: converted to the numeric representation (was not the case)

* data is not recoded anymore, but label columns can be added to the data set by using `cbs_add_label_columns`.

* `View` shows the column title.

* `cbs_add_date_column` adds a column with the period converted to `Date` or `numeric`.

# version 0.2.3

* added with strip.whitespace to `get_data` (issue #4), suggestion of Jonathan de Bruin

* changed address of opendata to https variant.

# version 0.2.2

*  used `httr`: better performance and error handling of failed connections.

* add `get_tables_themes` : suggestion of Wietse Dol.
