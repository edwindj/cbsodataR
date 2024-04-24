#' extract the default selection from a cbsodata meta object
#' 
#' @param x meta object
#' @param ... for future use
cbs_default_selection <- function(x, ...){
  #toc$DefaultSelection
  parts <- parse_odata_link(x$TableInfos$Identifier, x$TableInfos$DefaultSelection)
  return(parts)
  #params <- get_params(x$TableInfos$DefaultSelection)
  
  #filter <- parts$filter
  # filter <- strsplit(filter, " and ")[[1]]
  # filter <- strsplit(filter, " or ")
  
  # vars <- sapply(filter, function(x){
  #   sub("\\(\\((\\w+).+", "\\1", x[1])
  # })
  # 
  # codes <- sapply(filter, function(x){
  #   pat <- ".+eq '(.+)'.+"
  #   m <- grepl(pat, x)
  #   sub(pat, "\\1", x)[m]
  # })
  # 
  # names(codes) <- vars
  # if(!is.null(params$`$select`)){
  #   codes$select <- strsplit(params$`$select`, ", ")[[1]]
  # }
  # c(id = x$TableInfos$Identifier, codes)
}

# utility
get_params <- function(x, ...){
  params <- strsplit(x, "&")[[1]]
  params <- lapply(params, function(p){
    kv <- strsplit(p, "=")[[1]]
    list(key = kv[1], value = kv[2])
  })
  values <- lapply(params, `[[`, "value")
  names(values) <- sapply(params, `[[`, "key")
  values
}