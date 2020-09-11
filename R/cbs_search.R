#' Find tables containing certain words
#' 
#' Find tables containing certain words.
#' 
#' The `format` can be either:
#' 
#' * `toc`: the same format as [cbs_get_toc()], with an extra `score` column.
#' * `docs`: the table results from the solr query, 
#' * `raw`: the complete results from the solr query.
#' 
#' @param query `character` with the words to search for.
#' @param catalog the subset in which the table is to be found see [cbs_get_catalogs()].
#' @param language should the `"nl"` (Dutch) or `"en"` (English) search index 
#' be used.
#' @param format format in which the result should be returned, see details
#' @param verbose `logical` should the communication with the server be shown?
#' @param ... not used
#' @example ./example/cbs_search.R
#' @export
cbs_search <- function( query
                      , catalog = "CBS"
                      , language = "nl"
                      , format=c("toc","docs", "raw")
                      , verbose = FALSE
                      , ...
                      ){
  
  format <- match.arg(format)

  query <- paste(query, collapse = " ")
  query <- URLencode(query)
  
  cats <- cbs_get_catalogs()
  if (!(catalog %in% cats$catalog)){
    stop("catalog has invalid value. Must be one of: "
           , paste0('"',cats$catalog, '"',collapse = ", ")
           , "."
           , call. = FALSE
           )
  }

  catalog_la <- paste(catalog, language, sep = "_")
  
  SEARCH <- file.path(BASE_URL, "solr", catalog_la, "select")
  query_url <- paste0(SEARCH
                     , "?q=", query
                     , "&wt=json"
                     )
  res <- get_json(query_url, verbose = verbose)
  docs <- res$response$docs
  switch( format
        , docs = docs
        , raw  = res
        , {
          toc <- cbs_get_datasets(catalog = catalog, ...)
          idx <- match(docs$PublicationKey, toc$Identifier)
          toc <- toc[idx,]
          cbind(score = docs$score, toc)
        }
        )
}
