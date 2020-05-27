
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
  
  # appearantly the deeplink service only works on BASE_URL 
  text <- readLines(file.path(BASE_URL, "deeplinkservice/deeplink", dl), warn = FALSE)
  text <- gsub("\"", "", text)
  info <- parse_odata_link(id, text)
  # info <- url_params(text)
  # info$id <- id
  # info <- info[c("id", "$select", "$filter")]
  # names(info) <- c("id", "select", "filter")
  # info$filter <- resolve_filter(info$filter)
  # info$select <- resolve_select(info$select)
  info$deeplink <- deeplink
  cgd <- c( quote(cbs_get_data)
          , id = info$id
          , info$filter
          , list(select = info$select)
          , list(...)
          , base_url = base_url
          )
  info$query <- as.call(cgd)
  info
}

parse_odata_link <- function(id, text, ...){
  info <- url_params(text)
  info$id <- id
  info <- info[c("id", "$select", "$filter")]
  names(info) <- c("id", "select", "filter")
  info$filter <- resolve_filter(info$filter)
  info$select <- resolve_select(info$select)
  info
}


url_params <- function(query){
  params <- strsplit(query, "&")[[1]]
  keys <- sub("=.*", "", params)
  values <- sub(".*=", "", params)
  names(values) <- keys
  as.list(values)
}

OR_CLAUSES <- "\\s+or\\s+"
AND_CLAUSES <- "\\s+and\\s+"
BRACKETS <- "^\\s*\\((.*)\\)\\s*$"

resolve_filter <- function(filter, quoted = TRUE){
  if (is.null(filter)){
    return(NULL)
  }
  #browser()
  a <- strsplit(filter, AND_CLAUSES)[[1]]
  
  # remove matching () at beginning and end
  a <- sub(BRACKETS, "\\1", a)
  
  a <- strsplit(a, OR_CLAUSES)
  
  a <- lapply(a, function(x){
    # remove matching () at beginning and end
    sub(BRACKETS, "\\1", x)
  })
  
  # todo improve detecting substring
  nms <- character(length(a))
  EQ <- "(\\w+) eq '(.*)'"
  SUBSTRINGOF <- "substringof\\('([^)]+)'\\s*,\\s*(\\w+)\\)"
  
  eq_query <- lapply(a, function(x){grep(EQ, x)})
  substringof_query <- lapply(a, function(x){grep(SUBSTRINGOF, x)})

  nms <- mapply(function(x, eq, ss){
    if (length(eq)){
      eq <- eq[1]
      sub(EQ, "\\1", x[eq])
    } else if (length(ss)){
      ss <- ss[1]
      sub(SUBSTRINGOF, "\\2", x[ss])
    }
  }, a, eq_query, substringof_query)
  
  cats <- mapply(function(x, eqs, column){
    if (length(eqs)){
      eqs <- sub(EQ, "\\2", x[eqs])
      eqs <- substitute(eq(eqs), list(eqs =eqs))
      eqs
    }
  }, a, eq_query, nms)
  
  substrings <- mapply(function(x, ss, column){
    if (length(ss)){
      ss <- sub(SUBSTRINGOF, "\\1", x[ss])
      ss <- substitute(has_substring(ss), list(ss = ss))
      ss
    }
  }, a, substringof_query, nms)
  
  cats <- mapply(function(eq, ss){
    if (length(eq)){
      if (length(ss)){
        substitute( ss | eq, list(eq=eq[[2]], ss =ss))
      } else {
        # return just the character (more readable)
        eq[[2]]
      }
    } else {
      ss
    }
  }, cats, substrings, SIMPLIFY = FALSE)
  
  if (!isTRUE(quoted)){
    cats <- lapply(cats, eval)
  }
  
  names(cats) <- nms
  cats
}

resolve_select <- function(select){
  if (is.null(select)){
    return(NULL)
  }
  strsplit(select, "\\s*,\\s*")[[1]]
}

