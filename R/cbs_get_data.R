#' Get data from Statistics Netherlands (CBS)
#' 
#' Retrieves data from a table of Statistics Netherlands. A list of available tables
#' can be retrieved with [cbs_get_toc()]. Use the `Identifier` column of 
#' `cbs_get_toc` as `id` in `cbs_get_data` and `cbs_get_meta`.
#' 
#' To reduce the download time, optionaly the data can be filtered on category values: 
#' for large tables (> 100k records) this is a wise thing to do.
#' 
#' The filter is specified with (see examples below):
#' 
#' - `<column_name> = <values>` in which `<values>` is a character vector.
#' Rows with values that are not part of the character vector are not returned. 
#' __Note that the values have to be values from the `$Key` column of the corresponding meta data. These may contain trailing spaces...__
#' 
#' - `<column_name> = has_substring(x)` in which x is a character vector. Rows with values that 
#' do not have a substring that is in x are not returned. Useful substrings are
#' "JJ", "KW", "MM" for Periods (years, quarters, months) and "PV", "CR" and "GM"
#' for Regions (provinces, corops, municipalities).
#' 
#' - `<column_name> = eq(<values>) | has_substring(x)`, which combines the two statements above.
#'             
#' 
#' By default the columns will be converted to their type (`typed=TRUE`).
#' CBS uses multiple types of missing (unknown, surpressed, not measured, missing): users
#' wanting all these nuances can use `typed=FALSE` which results in character columns.
#' 
#' @note All data are downloaded using [cbs_download_table()]
#' 
#' @param id Identifier of table, can be found in [cbs_get_toc()]
#' @param ... optional filter statements, see details.
#' @param select `character` optional, columns to select
#' @param add_column_labels Should column titles be added as a label (TRUE) which are visible in `View`
#' @param dir Directory where the table should be downloaded. Defaults to temporary
#' directory
#' @param typed Should the data automatically be converted into integer and numeric?
#' @param verbose Print extra messages what is happening.
#' @param include_ID Should the data include the ID column for the rows?
#' @param base_url optionally specify a different server. Useful for
#' third party data services implementing the same protocol.
#' @return `data.frame` with the requested data. Note that a csv copy of
#'  the data is stored in `dir`.
#' @export
#' @seealso [cbs_get_meta()], [cbs_download_data()]
#' @family data retrieval
#' @family query
#' @example ./example/query.R
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
