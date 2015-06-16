#' Get data from Statistics Netherlands (CBS)
#' 
#' Retrieves data from a table of Statistics Netherlands. A list of tables
#' can be retrieved with \code{\link{get_table_list}}. 
#' Optionaly the data can be filtered on category values.
#' 
#' @note All data are downloaded using \code{\link{download_table}}
#' 
#' @param id Identifier of table, can be found in \code{\link{get_table_list}}
#' @param ... optional filter statemenets
#' @param recode Should the categories of the table be recoded with their title
#' or with their key?
#' @param dir Directory where the table should be downloaded. Defaults to temporary
#' directory
#' @export
get_data <- function(id, ..., recode=TRUE, dir=tempdir()){
  meta <- download_table(id, ..., dir=dir)
  data <- read.csv(file.path(dir, "data.csv")) 
  
  if (recode){
    
    dims <- names(data)[names(data) %in% names(meta)]
    for (d in dims){
      x <- as.factor(data[[d]])
      dim <- meta[[d]]
      levels(x) <- dim$Title[match(levels(x), dim$Key)]
      data[[d]] <- x
    }
    #TODO recode column names from meta$DataProperties
  }
  
  class(data) <- c('tbl', 'tbl_df', 'data.frame')
  data
}

#get_data("81819NED")
