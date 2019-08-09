#' Download all data from Statistics Netherlands / CBS
#' 
#' `cbsodataR` allows to download all official statistics of Statistics
#' Netherlands (CBS) into R. For a introduction please visit the 
#' [vignette](https://edwindj.github.io/cbsodataR/articles/cbsodataR.html): 
#' `vignette("cbsodataR", package="cbsodataR")`. 
#' The functions [cbs_get_toc()]
#' and [cbs_get_data()] should get you going.
#' 
#' @section Catalog function:
#' 
#' - [cbs_get_toc()], returns a data.frame with table of contents (toc): the publication
#' meta data for all available tables
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
#'@importFrom utils read.csv write.csv write.table View
#'@docType package
"_PACKAGE"

BASE_URL = "http://opendata.cbs.nl"
API = "ODataApi/odata"
BULK = "ODataFeed/odata"

CATALOG = "ODataCatalog"



