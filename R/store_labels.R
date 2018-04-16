# adds labels to factor/character columns based on the corresponding meta data
store_labels <- function(x, meta, ...){
  nms <- names(x)
  
  for (n in nms[nms %in% names(meta)]){
    var_meta <- meta[[n]]
    lbld <- var_meta$Key
    names(lbld) <- var_meta$Title
    attr(x[[n]], "labels") <- lbld
    #class(x[[n]]) <- c("labelled", class(x[[n]]))
  }
  x
}

# x <- get_cbs_data("81819NED")
# meta <- get_cbs_meta("81819NED", cache = TRUE)

# x2 <- add_labelled(x, meta, use_labels = TRUE, add_codes = "Perioden")
# str(x2)
