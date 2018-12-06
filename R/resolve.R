#' @importFrom jsonlite fromJSON
#' @importFrom utils URLencode
resolve_resource <- function(url, ..., verbose = TRUE, cache=TRUE){
  url <- utils::URLencode(url)
  
  if (isTRUE(cache)){
    res <- cache_get(url)
    if (!is.null(res)){
      return(res)
    }
  }
  
  if (verbose) { message(...," ", url) }
  # od <- httr::GET(url, httr::accept_json())
  # httr::stop_for_status(od, task = httr::http_status(od)$message)
  # res <- httr::content(od, "text", encoding="UTF-8")
  # res <- jsonlite::fromJSON(res)$value
  res <- get_json(url, verbose = verbose)$value
  
  if (isTRUE(cache)){
    cache_add(url, res)
  }
  res
}


get_json <- function(url, verbose = TRUE){
  if (verbose){
    cat(url)
  }
  
  tryCatch({
    jsonlite::read_json(url, simplifyVector = TRUE)},
    error = function(e){
       warning("Failing: ", url, "\nRetrying...", call. = FALSE)
       jsonlite::read_json(url, simplifyVector = TRUE)
     }
    )
  # od <- httr::GET(url, httr::accept_json())
  # httr::stop_for_status(od, task = httr::http_status(od)$message)
  # res <- httr::content(od, "text", encoding="UTF-8")
  # jsonlite::fromJSON(res)
}