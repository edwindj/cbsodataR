get_bulk_url <- function(
    base_url = getOption("cbsodataR.base_url", BASE_URL)
){
  bulk_url <- getOption("cbsodataR.odatafeed_url", 
     file.path(base_url, getOption("cbsodataR.BULK", BULK))
  )
  bulk_url
}

get_api_url <- function(
    base_url = getOption("cbsodataR.base_url", BASE_URL)
){
  api_url <- getOption("cbsodataR.odataapi_url", 
                        file.path(base_url, getOption("cbsodataR.API", API))
  )
  api_url
}

