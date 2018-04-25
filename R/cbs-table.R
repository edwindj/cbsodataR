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
  cat(ti$Identifier, ": '", ti$ShortTitle, "', ", ti$Period, sep="")
  
  if (!is.null(x$directory)){
    cat(" ('",x$directory,"')", sep="")
  }
  cat("\n")
  
  dp <- x$DataProperties
  dims <- dp[grep("Dimension", dp$Type),]
  
  cat(paste0("  ", dims$Key, ": '", dims$Title, "'", collapse = "\n"), "\n")
  cat("\nRetrieve a default data selection with:\n\t")
  print(as.expression(x))
}

#' @export
as.expression.cbs_table <- function(x, ...){
  as.call(c(quote(cbs_get_data), cbs_default_selection(x)))
}

# testing 1, 2, 3

# m <- as.cbs_table("81819NED")
