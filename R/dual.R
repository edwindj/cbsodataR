# # create a query from a dual
# fromDUAL <- function(url){
#   dual <- httr::parse_url(url)
#   meta <- get_meta(dual$query$PA)
#   data_props <- meta$DataProperties
#   dims <- data_props[data_props$Type %in% c("Dimension", "TimeDimension", "RegionDimension"),]
#   dims <- dims[c("Position", "Key")]
#   dims$D <- paste0("D", dims$Position + 1)
# }
# 
# #url <- "http://statline.cbs.nl/StatWeb/publication/default.aspx?DM=SLNL&PA=7052_95&D1=20&D2=0&D3=l&D4=a&HDR=G2%2cG3&STB=T%2cG1&VW=T"
# 
# #View(meta)
