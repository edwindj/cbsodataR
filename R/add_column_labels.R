# utility function adding labels to columns
add_var_labels <- function(x, meta){
  props <- meta$DataProperties
  labels <- stats::setNames(props$Title, props$Key)
  for (n in names(x)){
    lbl <- unname(labels[n])
    if (is.na(lbl) || is.null(lbl)){
      next
    }
    attr(x[[n]], "label") <- unname(labels[n])
  }
  x
}


# utility function adding units to columns
add_var_units <- function(x, meta){
  props <- meta$DataProperties
  units <- stats::setNames(props$Unit, props$Key)
  for (n in names(x)){
    unit <- unname(units[n])
    if (is.na(unit) || is.null(unit)){
      next
    }
    attr(x[[n]], "unit") <- unname(units[n])
  }
  x
}

#View(add_label(x, meta))
#x <- get_cbs_data("81819NED")
#meta <- get_meta("81819NED", verbose = FALSE)
