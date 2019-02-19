version 0.3.2
- Added a new function cbs_get_data_from_link to allow for retrieving data using a link created with the opendata portal. Thanks to Albert Pieters for the suggestion
- Improved the base_url default value.
- fixed a bug in cbs_get_data, key columns were not always loaded as character columns (issue #15). Thanks 
to @VincentKars

version 0.3.1
- removed httr and changed to jsonlite::read_json. httr gave problems with some Windows configurations.
- fixed cbs_get_toc with select argument (issue #12). Thanks to Rob van Harrevelt.

version 0.3

- changed api: all (new) functions are prefixed with `cbs_` to have a more clean programming interface. 
- old functions are still available and working but are deprecated.
- `verbose=FALSE` and `cache=TRUE` by default: (for new functions).
- `get_table_list` renamed to `cbs_get_toc`
- data by default is `typed`: converted to the numeric representation (was not the case)
- data is not recoded anymore, but label columns can be added to the data set by using `cbs_add_label_columns`.
- `View` shows the column title.
- `cbs_add_date_column` adds a column with the period converted to `Date` or `numeric`.

version 0.2.3

- added with strip.whitespace to `get_data` (issue #4), suggestion of Jonathan de Bruin
- changed address of opendata to https variant.

version 0.2.2

- used `httr`: better performance and error handling of failed connections.
- add `get_tables_themes` : suggestion of Wietse Dol.