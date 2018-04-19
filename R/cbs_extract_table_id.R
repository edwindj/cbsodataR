#' extract the id of a cbs table from the statline url
#' @param url \code{character} with hyperlink to StatLine table
#' @param ... future use.
#' @return \code{character} with id, will be NA if not found.
cbs_extract_table_id <- function(url, ...){
  # TODO add check if succeeded
  
  id <- sub(".+/dataset/(\\w+).+", "\\1", url)
  
  if (url == id){
    return(NA)
  }
  
  toc <- cbs_get_toc(...)
  
  if (!(id %in% toc$Identifier)){
    warning("id: '", id, "' does not seem a valid id (see get_cbs_toc)", call. = FALSE)
  }
  
  id
}

# testing 1,2,3
# url <- "https://opendata.cbs.nl/statline/#/CBS/nl/dataset/70072ned/table?dl=AB73"
# cbs_extract_table_id(url)