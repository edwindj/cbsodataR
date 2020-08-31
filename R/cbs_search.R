#' Find tables containing certain words
#' 
#' Find tables containing certain words.
#' 
#' The `type` can be either:
#' 
#' * `toc`: the same format as [cbs_get_toc()]
#' * `docs`: the table results from the solr query, 
#' * `raw`: the complete results from the solr query.
#' 
#' @param query `character` with the words to search for.
#' @param type format in which the result should be returned, see details
#' @param verbose `logical` should the communication with the server be shown?
#' @param ... not used
#' @export
cbs_search <- function(query, type=c("toc","docs", "raw"), verbose = FALSE, ...){
  type <- match.arg(type)
  
  query <- paste(query, collapse = " ")
  query <- URLencode(query)
  
  SEARCH <- file.path(BASE_URL, "solr/CBS_nl/select")
  query_url <- paste0(SEARCH
                     , "?q=", query
                     , "&wt=json"
                     )
  res <- get_json(query_url, verbose = verbose)
  docs <- res$response$docs
  switch( type
        , docs = docs
        , raw  = res
        , {
          toc <- cbs_get_toc()
          idx <- match(docs$PublicationKey, toc$Identifier)
          toc <- toc[idx,]
          cbind(score = docs$score, toc)
        }
        )
}
