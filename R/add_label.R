# utility function adding labels to columns
add_label <- function(x, meta){
  
  props <- meta$DataProperties
  labels <- setNames(props$Title, props$Key)
  for (n in names(x)){
    attr(x[[n]], "label") <- unname(labels[n])
  }
  x
}


View(add_label(x, meta))
#x <- get_cbs_data("81819NED")
#meta <- get_meta("81819NED", verbose = FALSE)
