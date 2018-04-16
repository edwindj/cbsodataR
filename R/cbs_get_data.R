#' Get data from Statistics Netherlands (CBS)
#' 
#' Retrieves data from a table of Statistics Netherlands. A list of tables
#' can be retrieved with \code{\link{cbs_get_toc}}. 
#' Optionaly the data can be filtered on category values. 
#' The filter is specified with \code{<column_name> = <values>} in which \code{<values>} is a character vector.
#' Rows with values that are not part of the character vector are not returned. Note that the values
#' have to be raw (un-recoded) values.
#' 
#' @note All data are downloaded using \code{\link{cbs_download_table}}
#' 
#' @param id Identifier of table, can be found in \code{\link{cbs_get_toc}}
#' @param ... optional filter statemenets
#' @param add_column_labels Should column titles be added as a label (TRUE) which are visible in \code{View}
#' @param dir Directory where the table should be downloaded. Defaults to temporary
#' directory
#' @param typed Should the data automatically be converted into integer and numeric?
#' @param verbose Print extra messages what is happening.
#' @param include_ID Should the data include the ID column for the rows?
#' @param base_url optionally specify a different server. Useful for
#' third party data services implementing the same protocol.
#' @return \code{data.frame} with the requested data. Note that a csv copy of the data is stored in \code{dir}.
#' @export
#' @examples 
#' \dontrun{
#' 
#' # get data for main (000000) Consumer Price Index (7196ENG) for March 2000, 
#'  cbs_get_data(id="7196ENG", Periods="2000MM03", CPI="000000")
#' }
cbs_get_data <- function( id
                        , ...
                        , typed             = TRUE
                        , add_column_labels = TRUE
                        , dir               = tempdir()
                        , verbose           = FALSE
                        , base_url          = CBSOPENDATA
                        , include_ID        = FALSE
                        ){
  
  meta <- cbs_download_table( id, ...
                        , dir      = dir
                        , cache    = TRUE
                        , typed    = typed
                        , verbose  = verbose
                        , base_url = base_url
                        )
  
  data <- read.csv(file.path(dir, "data.csv"), strip.white = TRUE)
  if (!include_ID){
    data <- data[-1]
  }
  
  data <- store_labels(data, meta)

  if (add_column_labels){
    data <- add_var_labels(data, meta)
  }
  
  class(data) <- c('tbl_df', 'tbl','data.frame')
  data
}

#x <- cbs_get_data("81819NED")
