#' @importFrom jsonlite fromJSON
#' @importFrom utils URLencode
resolve_resource <- function(url, ..., cache=TRUE){
  url <- utils::URLencode(url)
  
  if (isTRUE(cache)){
    res <- cache_get(url)
    if (!is.null(res)){
      return(res)
    }
  }
  
  message(...," ", url)
  od <- httr::GET(url, httr::accept_json())
  httr::stop_for_status(od, task = httr::http_status(od)$message)
  # if (httr::http_error(od)){
  #   warning(httr::http_status(od))
  #   return(NULL)
  # }
  
  res <- httr::content(od, "text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)$value
  
  if (isTRUE(cache)){
    cache_add(url, res)
  }
  res
}
