#' Download all data from Statistics Netherlands / CBS
#' 
#' `cbsodataR` allows to download all official statistics of Statistics
#' Netherlands (CBS) into R. For a introduction please visit the 
#' [vignette](https://edwindj.github.io/cbsodataR/articles/cbsodataR.html): 
#' `vignette("cbsodataR", package="cbsodataR")`. For an introduction on using 
#' cbs cartographic maps: `vignette("maps", package="cbsodataR")`
#' The functions [cbs_get_datasets()]
#' and [cbs_get_data()] should get you going. 
#' Interested in cartographic maps, see [cbs_get_maps()].
#' 
#' @section Catalog function:
#' 
#' - [cbs_get_datasets()] returns a data.frame with table of contents (toc): the publication
#'  meta data for available tables, can also include the extra tables not directly available
#'  in StatLine (dataderden)
#'  
#' - [cbs_get_catalogs()], returns data.frame with the available (extra) catalogs.
#' 
#' - [cbs_get_toc()], returns a data.frame with table of contents (toc): the publication
#' meta data for available tables within the standard CBS
#' 
#' - [cbs_search()], returns a data.frame with tables that contain the given 
#' search word.
#' 
#' 
#' @section Data retrieval:
#' 
#' - [cbs_get_data()], returns the data of a specific opendata/StatLine table
#' - [cbs_download_table()], saves the data (and metadata) as csv files 
#'    into a directory
#'    
#' @section Meta data:
#' 
#' - [cbs_get_meta()], returns the meta data objects of a specific opendata / StatLine
#' table .
#' - [cbs_add_date_column()], converts date/period codes into `DateTime` objects 
#' in the data set that was downloaded.
#' - [cbs_add_label_columns()], adds labels to the code columns in the data that
#' was downloaded.
#' 
#' @section Cartographic maps:
#' 
#' - [cbs_get_maps()], returns a data.frame with available CBS maps
#' - [cbs_join_sf_with_data()], returns an sf object joined with cbs table
#' - [cbs_get_sf()], returns an sf object without data, e.g. "gemeente_2020".
#' 
#' @section Copyright use:
#' The content of CBS opendata is subject to Creative Commons Attribution (CC BY 4.0). 
#' This means that the re-use of the content is permitted, provided Statistics 
#' Netherlands is cited as the source. For more information see:
#' <https://www.cbs.nl/en-gb/about-us/website/copyright>
#' 
#'@importFrom utils read.csv write.csv write.table View
#'@docType package
"_PACKAGE"

BASE_URL = "http://opendata.cbs.nl"
API = "ODataApi/odata"
BULK = "ODataFeed/odata"

CATALOG = "ODataCatalog"



