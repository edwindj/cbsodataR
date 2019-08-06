#' Get meta data from table
#' 
#' This method is deprecated in favor of [cbs_get_meta()]
#' @inherit cbs_get_meta
#' @name get_meta-deprecated
#' @export
get_meta <- function( id
                    , verbose  = TRUE
                    , cache    = FALSE
                    , base_url = getOption("cbsodataR.base_url", BASE_URL)
                    ){
  .Deprecated("cbs_get_meta")
  url <- whisker.render("{{BASEURL}}/{{API}}/{{id}}"
                       , list( BASEURL = base_url
                             , API = API
                             , id = id
                             )
                       )
  meta_top <- resolve_resource( url
                              , "Retrieving meta data for table '", id, "'"
                              , verbose = verbose
                              , cache = cache
                              )
  
  #exclude data sets
  meta_idx = !(meta_top$name %in% c("TypedDataSet", "UntypedDataSet"))
  meta_top <- meta_top[meta_idx,]
  
  meta <- lapply( meta_top$url
                , resolve_resource, "Retrieving "
                , url
                , cache   = cache
                , verbose = verbose
                )
  names(meta) <- meta_top$name
  structure( meta
           , class="cbs_table"
           )
}


#' Load meta data from a downloaded table
#' 
#' @param dir Directory where data was downloaded
#' @return cbs_table object with meta data
#' @export
get_meta_from_dir <- function(dir){
  .Deprecated("cbs_get_meta_from_dir")
  wd <- setwd(dir)
  on.exit(setwd(wd))
  
  meta_files <- list.files(".", "*.csv")
  meta_files <- meta_files[meta_files != "data.csv"]
      
  # meta <- lapply(meta_files, read.csv, colClasses="character")
  names(meta) <- sub("\\.csv$","", meta_files)
  meta$directory <- dir
  structure( meta
           , class="cbs_table"
           )
}

### testing


#dump_meta("81819NED")
#get_meta_from_dir("D:/data/StatLine/00370/")

### testing
#meta <- get_meta("81819NED")
