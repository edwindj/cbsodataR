#' Get data from Statistics Netherlands (CBS)
#' 
#' Retrieves data from a table of Statistics Netherlands. A list of available tables
#' can be retrieved with \code{\link{cbs_get_toc}}. Use the \code{Identifier} column of 
#' \code{cbs_get_toc} as \code{id} in \code{cbs_get_data} and \code{cbs_get_meta}.
#' Optionaly the data can be filtered on category values. 
#' The filter is specified with \code{<column_name> = <values>} in which \code{<values>} is a character vector.
#' Rows with values that are not part of the character vector are not returned. Note that the values
#' have to be raw (un-recoded) values.
#' 
#' By default the columns will be converted to their type (\code{typed=TRUE}).
#' CBS uses multiple types of missing (unknown, surpressed, not measured, missing): users
#' wanting all these nuances can use \code{typed=FALSE} which results in character columns.
#' 
#' @note All data are downloaded using \code{\link{cbs_download_table}}
#' 
#' @param id Identifier of table, can be found in \code{\link{cbs_get_toc}}
#' @param ... optional filter statements
#' @param select \code{character} optional, columns to select
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
#' @seealso \code{\link{cbs_get_meta}}, \code{\link{cbs_download_data}}
#' @examples 
#' \dontrun{
#' 
#' # get data for main (000000) Consumer Price Index (7196ENG) for March 2000, 
#'  cbs_get_data(id="7196ENG", Periods="2000MM03", CPI="000000")
#' }
cbs_get_data <- function( id
                        , ...
                        , select            = NULL
                        , typed             = TRUE
                        , add_column_labels = TRUE
                        , dir               = tempdir()
                        , verbose           = FALSE
                        , base_url          = getOption("cbsodataR.base_url", BASE_URL)
                        , include_ID        = FALSE
                        ){
  
  meta <- cbs_download_table( id
                        , ...
                        , select   = select
                        , dir      = dir
                        , cache    = TRUE
                        , typed    = typed
                        , verbose  = verbose
                        , base_url = base_url
                        )
  dimnames <- names(meta)[names(meta) %in% meta$DataProperties$Key]
  colClasses <- sapply(dimnames, function(x){"character"})
  data <- read.csv( file.path(dir, "data.csv")
                  , colClasses = colClasses
                  , strip.white = TRUE)
  if (!include_ID && is.null(select)){
    data <- data[-1]
  }
  
  data <- store_labels(data, meta)

  if (add_column_labels){
    data <- add_var_labels(data, meta)
  }
  
  is_time <- meta$DataProperties$Key[meta$DataProperties$Type == "TimeDimension"]
  if (length(is_time)){
    attr(data[[is_time]], "is_time") <- TRUE
  }
  
  class(data) <- c('tbl_df', 'tbl','data.frame')
  data
}

#x <- cbs_get_data("81819NED")
