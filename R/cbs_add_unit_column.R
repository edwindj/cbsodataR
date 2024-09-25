#' For each topic column add a unit column
#' 
#' Adds extra unit columns to the dataset that was retrieved using [cbs_get_data()].
#' 
#' The unit columns will be named `<topic_column>_unit`, and are a `character`
#' 
#' By default all topic columns will be with a unit column. The name
#' of each unit column will be `<topic_column>_unit`.
#' @export
#' @param x `data.frame` retrieved using [cbs_get_data()].
#' @param columns `character` with the names of the columns for which units will be added, 
#' non-topic columns will be ignored.
#' @param ... not used.
#' @return the original data.frame `x` with extra unit
#' columns. (see description)
#' @family data retrieval
#' @family meta data
#' @example example/cbs_add_unit_column.R
cbs_add_unit_column <- function(x, columns=colnames(x), ...){
  add <- list()
  nms <- colnames(x)
  N <- nrow(x)
  
  for (n in columns){
    values <- x[[n]]
    
    if (is.null(values)){
      warning("Column '", n, "' does not exist.")
      next
    }
    
    unit <- attr(x[[n]], "unit")
    if (is.null(unit)){
      next
    }
    un <- paste0(n, "_unit")
    x[[un]] <- rep(unit, N)
    add[[n]] <- un
  }
  # rearrange column order
  cols <- unlist(lapply(nms, function(n){c(n, add[[n]])}))
  x[,cols]
}