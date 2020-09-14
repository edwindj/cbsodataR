get_row_count <- function(id, catalog = "CBS", ...){
  meta <- as.cbs_table(id, catalog = catalog)
  
  dp <- meta$DataProperties
  dims <- dp[grep("Topic", dp$Type, invert = TRUE),]
  dim_sizes <- sapply(meta[dims$Key], nrow)
  
  filter_list <- list(...)
  
  sizes <- sapply(names(filter_list), function(column){
    f <- column_filter( column
                      , filter_list[[column]]
                      , allowed = meta[[column]][["Key"]]
                      )
    f$size
  })
  dim_sizes[names(sizes)] <- as.integer(sizes)
  size <- prod(dim_sizes)
  #list(dim_sizes = dim_sizes, sizes = sizes, size = size)
  size
}

#get_row_count("7196ENG")
