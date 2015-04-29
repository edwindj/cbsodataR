
get_data <- function(id, output_con=file(), ..., select=NULL){
  url <- whisker.render("{{BASEURL}}/{{BULK}}/{{id}}/TypedDataSet?$format=json"
                        , list( BASEURL = BASEURL
                                , BULK = BULK
                                , id = id
                        )
  )
  url <- paste0(url, get_query(..., select=select))
  res <- jsonlite::fromJSON(url)
  jsonlite::stream_out(res$value, con=output_con)
  while (!is.null(url <- res$odata.nextLink)){
    res <- jsonlite::fromJSON(url)
    jsonlite::stream_out(res$value, con=output_con)
  }
}

#get_data("81819NED")
