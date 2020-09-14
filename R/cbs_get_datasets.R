#' Retrieve a data.frame with requested cbs tables
#' 
#' `cbs_get_datasets` by default a list of all tables and all columns will be retrieved.
#' You can restrict the query by supplying multiple filter statements or by specifying the
#' columns that should be returned.
#' 
#' Note that setting `catalog` to `NULL` results in a datasets list with all tables including
#' the extra catalogs.
#' 
#' @inheritParams cbs_get_toc
#' @param catalog which set of tables should be returned? [cbs_get_catalogs()] 
#' or supply `NULL` for all tables.
#' @example ./example/cbs_get_datasets.R
#' @export
cbs_get_datasets <- function( catalog       = "CBS"
                            , convert_dates = TRUE
                            , select        = NULL
                            , verbose       = FALSE
                            , cache         = TRUE
                            , base_url      = getOption("cbsodataR.base_url", BASE_URL)
                            , ...
                            ){
  toc <- .cache$cbs_get_datasets
  if (is.null(toc)){
    toc <- cbs_get_toc( ...
                      , convert_dates = convert_dates
                      , select = select
                      , verbose = verbose
                      , cache = cache
                      , base_url = base_url
                      , include_ID = FALSE
                      )
    
    try({
      toc2 <- cbs_get_toc(...
                         , convert_dates = convert_dates
                         , select        = select
                         , verbose       = verbose
                         , cache         = cache
                         , base_url      = "https://dataderden.cbs.nl"
                         , include_ID    = FALSE
                         )
      toc <- rbind(toc, toc2)
    }, silent = TRUE)
    .cache$cbs_get_datasets <- toc
  }
  if (!is.null(catalog)){
    cats <- unique(toc$Catalog)
    if (!(catalog %in% cats)){
      stop("Invalid value for `catalog`, should be one of: "
          , paste0('"', cats ,'"', collapse = ", ")
          , 'or `NULL`'
          , call. = FALSE 
          )
    }
    toc <- toc[toc$Catalog == catalog, ]
  }
  toc
}
