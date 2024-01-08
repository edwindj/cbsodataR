#' Find tables containing search words
#' 
#' Find tables containing search words.
#' 
#' The `format` can be either:
#' 
#' * `datasets`: the same format as [cbs_get_datasets()], with an extra `score` column.
#' * `docs`: the table results from the solr query, 
#' * `raw`: the complete results from the solr query.
#' 
#' @param query `character` with the words to search for.
#' @param catalog the subset in which the table is to be found, see 
#' [cbs_get_catalogs()], set to `NULL` to query all catalogs.
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
                      , format=c("datasets","docs", "raw")
                      , verbose = FALSE
                      , ...
                      ){
  format <- match.arg(format)

  query <- paste(query, collapse = " ")
  query <- URLencode(query)
  
  cats <- if (!is.null(catalog) && catalog == "CBS") {
    data.frame(Identifier = "CBS")
  } else {
    cbs_get_catalogs()
  }
  if (is.null(catalog)){
    #message("Search all")
    l_search <- lapply(cats$Identifier, function(catalog){
      cbs_search(query, catalog=catalog, language = language
                , format = format, verbose =verbose)
    })
    if (format != "raw"){
      l_search <- do.call(rbind, l_search)
    }
    return(l_search)
  }
  
  if (!(catalog %in% cats$Identifier)){
    stop("catalog has invalid value. Must be one of: "
        , paste0('"',cats$Identifier, '"',collapse = ", ")
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
          toc$score <-  if (is.null(docs$score)) numeric() else docs$score
          toc[,c("score", utils::head(names(toc), -1))]
        }
        )
}
