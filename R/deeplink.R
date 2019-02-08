
# TODO check if base_url is implemented internally for deeplinking
#DEEPLINK <- "https://opendata.cbs.nl/deeplinkservice/deeplink"
#deeplink <- "https://opendata.cbs.nl/dataportaal/#/CBS/nl/dataset/81573NED/table?dl=17022"
#deeplink <- "https://opendata.cbs.nl/dataportaal/#/CBS/en/dataset/71509ENG/table?dl=193CB"

#' resolve a deeplink created in the opendata portal
#' 
#' @param deeplink url to the deeplink in the opendataportal
#' @param ... used in the query
#' @param base_url optionally specify a different server. Useful for
#' third party data services implementing the same protocol.
#' @return information object with table id, select, filter and query statement.
resolve_deeplink <- function(deeplink, ..., base_url = getOption("cbsodataR.base_url", BASE_URL)){
  
  id <- sub(".*/dataset/(\\w+)/.*", "\\1", deeplink)
  query <- sub(".*\\?(.*)", "\\1", deeplink)
  dl <- url_params(query)$dl
  
  
  text <- readLines(file.path(base_url, "deeplinkservice/deeplink", dl), warn = FALSE)
  text <- gsub("\"", "", text)
  info <- url_params(text)
  info$id <- id
  info <- info[c("id", "$select", "$filter")]
  names(info) <- c("id", "select", "filter")
  info$filter <- resolve_filter(info$filter)
  info$select <- resolve_select(info$select)
  info$deeplink <- deeplink
  cgd <- c( quote(cbs_get_data)
          , id = info$id
          , info$filter
          , list(select = info$select)
          , list(...)
          )
  info$query <- as.call(cgd)
  info
}


url_params <- function(query){
  params <- strsplit(query, "&")[[1]]
  keys <- sub("=.*", "", params)
  values <- sub(".*=", "", params)
  names(values) <- keys
  as.list(values)
}

resolve_filter <- function(filter){
  if (is.null(filter)){
    return(NULL)
  }
  a <- strsplit(filter, "\\s+and\\s+")[[1]]
  a <- gsub("\\(|\\)", "", a)
  a <- strsplit(a, "\\s+or\\s+")
  nms <- sapply(a, function(x){
    sub("(\\w+) eq .*", "\\1", x[1])
  })
  cats <-lapply(a, function(x){
    sub(".*'([^']+)'", "\\1", x)
  })
  names(cats) <- nms
  cats
}

resolve_select <- function(select){
  if (is.null(select)){
    return(NULL)
  }
  strsplit(select, ", ")[[1]]
}
# TODO split stuff on filter and select

#resolve_deeplink(deeplink)
