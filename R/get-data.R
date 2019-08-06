#' Get data from Statistics Netherlands (CBS)
#' 
#' This method is deprecated in favor of [cbs_get_data()]
#' @inherit cbs_get_data
#' @name get_data-deprecated
#' @param recode recodes all codes in the code columns with their `Title` as found
#' in the metadata
#' @param use_column_title not used.
#' @export
get_data <- function( id, ..., recode=TRUE, use_column_title = recode, dir=tempdir()
                    , base_url = getOption("cbsodataR.base_url", BASE_URL)){
  .Deprecated("cbs_get_data")
  meta <- download_table(id, ..., dir=dir, cache=TRUE, base_url = base_url)
  data <- read.csv(file.path(dir, "data.csv"), colClasses="character", strip.white = TRUE)
  if (recode){
    dims <- names(data)[names(data) %in% names(meta)]
    for (d in dims){
      x <- as.factor(data[[d]])
      dim <- meta[[d]]
      levels(x) <- dim$Title[match(levels(x), dim$Key)]
      data[[d]] <- x
    }
    columns <- meta$DataProperties
    
    m <- match(columns$Key, colnames(data), nomatch = 0)
    
    # can cause duplicated names!
    #colnames(data)[m] <- columns$Title[m > 0]
    
    # TODO recode column names from meta$DataProperties and
    # convert columns to correct type.
  }
  
  class(data) <- c('tbl', 'tbl_df', 'data.frame')
  data
}

#get_data("81819NED")
