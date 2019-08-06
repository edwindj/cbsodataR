#' Retrieve data from a link created from the StatLine app.
#' 
#' Retrieve data from a link created from the StatLine app.
#' @param link url/hyperlink to opendata table made with the StatLine App
#' @param message \code{logical} Should the query be printed (default TRUE)
#' @param ... passed on to \code{\link{cbs_get_data}}
#' @param base_url optionally specify a different server. Useful for
#' third party data services implementing the same protocol.
#' @return Same as \code{\link{cbs_get_data}}
#' @family data retrieval
#' @export
cbs_get_data_from_link <- function( link, message = TRUE, ...
                                  , base_url = getOption("cbsodataR.base_url", BASE_URL)){
  info <- resolve_deeplink(link, ..., base_url = base_url)
  if (isTRUE(message)){
    message("Executing:\n", paste(deparse(info$query), collapse = ""))
  }
  eval(info$query)
}