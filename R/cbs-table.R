is.cbs_table <- function(x, ...){
  inherits(x, "cbs_table")
}

as.cbs_table <- function(id, ...){
  if (is.cbs_table(id)){
    return(id)
  }
  get_meta(id)
}

#' @export
print.cbs_table <- function(x, ...){
  ti <- x$TableInfos
  cat(ti$Identifier, ": '", ti$ShortTitle, "', ", ti$Period,"\n", sep="")
  dp <- x$DataProperties
  dims <- dp[grep("Dimension", dp$Type),]
  
  cat(paste0("  ", dims$Key, ": '", dims$Title, "'", collapse = "\n"), "\n")
}

# testing 1, 2, 3

# m <- as.cbs_table("81819NED")
