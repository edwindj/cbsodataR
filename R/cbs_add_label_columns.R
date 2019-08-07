#' For each column with codes add label column to data set
#' 
#' Adds cbs labels to the dataset that was retrieved using [cbs_get_data()].
#' 
#' Code columns will be translated into label columns for each of the column 
#' that was supplied. 
#' 
#' By default all code columns will be accompagnied with a label column. The name
#' of each label column will be `<code_column>_label`.
#' @export
#' @param x `data.frame` retrieved using [cbs_get_data()].
#' @param columns `character` with the names of the columns for which labels will be added
#' @param ... not used.
#' @return the original data.frame `x` with extra label 
#' columns. (see description)
#' @family data retrieval
#' @family meta data
#' @examples 
#' \dontrun{
#' 
#' # get data for main (000000) Consumer Price Index (7196ENG) for March 2000, 
#'  x <- cbs_get_data( id      = "7196ENG"
#'                   , Periods = "2000MM03"  # March 2000
#'                   , CPI     = "000000"    # main price index
#'                   )
#'  cbs_add_label_columns(x)
#' }
cbs_add_label_columns <- function(x, columns = colnames(x), ...){
  add <- list()
  nms <- colnames(x)
  for (n in columns){
    values <- x[[n]]
    
    if (is.null(values)){
      warning("Column '", n, "' does not exist.")
      next
    }
    
    lbls <- attr(x[[n]], "labels")
    if (is.null(lbls)){
        next
    }
    lbl <- paste0(n, "_label")
    x[[lbl]] <- factor(values, levels=unname(lbls), labels=names(lbls))
    add[[n]] <- lbl
  }
  # rearrange column order
  cols <- unlist(lapply(nms, function(n){c(n, add[[n]])}))
  x[,cols]
}

# x <- cbs_get_data("81819NED")
# cbs_add_label_columns(x)
