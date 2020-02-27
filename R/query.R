#' Detect codes in a column
#' 
#' Detects for codes in a column. `eq` filters the data set at CBS: rows that have 
#' a code that is not in `x` are filtered out.
#' @export
#' @param x exact code(s) to be matched in `column`
#' @param column name of column.
#' @param allowed `character` with allowed values. If supplied it will check if `x` 
#' is a code in `allowed`.
#' @return query object
#' @family query
#' @example ./example/query.R
eq <- function(x, column = NULL, allowed = NULL){
  values <- x
  size <- length(x)
  if (is.character(allowed)){
    valid <- values %in% allowed
    if (!all(valid)){
      warning("Value(s): "
              , paste0("'", values[!valid],"'", collapse = ", ")
              , " are not a valid selection for '",column, "'. "
              , "Consult the meta data."
              , call. = FALSE
      )
    }
    size <- sum(valid)
  }
  structure(
    list( x = x
        , column = column
        , size = size
        )
        , class=c("eq_query", "query")
  )
}

#' Detect substring in column `column`
#' 
#' Detects a substring in a column. `has_substring` filters the dataset at CBS: 
#' rows that have a code that does not contain (one of) `x` are filtered out. 
#' @export
#' @param x substring to be detected in column
#' @param column column name
#' @param allowed `character` with allowed values. If supplied it will check if `x` 
#' is a code in `allowed`.
#' @family query
#' @example ./example/query.R
has_substring <- function(x, column = NULL, allowed = NULL){
  size <- length(x) # bad init, but I don't know another way

  if (is.character(allowed)){
    m <- lapply(x, function(ss){
      m <- grep(ss, allowed)
      if (length(m) == 0){
        warning( "substring: '", ss, "' does not match any keys"
               , call. = FALSE
               )
      }
      m
    })
    m <- unique(unlist(m))
    size <- length(m)
  }
  
  structure(
    list( x = x
        , column = column
        , cmd = "substringof"
        , size = size
        ),
    class = "query"
  )
}

check_query <- function(x, allowed=NULL){
  if (is.null(allowed)){
    return(x)
  }
  
  if (inherits(x, 'or_query')){
    x$x <- lapply(x$x, check_query, allowed = allowed)
    return(x)
  }
  
  if (inherits(x, "eq_query")){
    return(eq(x$x, column = x$column, allowed = allowed))
  }
  
  has_substring(x$x, column = x$column, allowed = allowed)
}

column_startswith <- function(x, column){
  if (length(x) > 1){
    stop("'x' needs to be a single text")
  }
  structure(
    list( x = x
        , column = column
        , cmd = "startswith"
    ),
    class = "query"
  )
}

is_query <- function(x){
  inherits(x, "query")
}

#' @export
`|.query` <- function(x, y){
  
  if (is.character(y)){
    y <- eq(y, column = x$column)
  }
  
  if (inherits(x, "or_query")){
    res <- c(x$x, list(y))
  } else {
    res <- list(x,y)
  }
  column <- x$column
  structure( list(x = res, column = column, size = x$size + y$size)
           , class=c("or_query", "query")
           )
}


#' @export
as.character.query <- function(x, column = x$column, ...){
  query <- sapply(x$x, function(value){
    whisker.render("{{cmd}}('{{value}}', {{column}})"
                   , list(cmd = x$cmd, value = value, column = column)
    )
  })
  paste(query, collapse = " or ")
}

#' @export
as.character.or_query <- function(x, column = x$column, ...){
  query <- sapply(x$x, as.character, column = column)
  paste(query, collapse = " or ")
#  paste0("(", query, ")")
}

#' @export
as.character.eq_query <- function(x, column = x$column, ...){
  values <- paste0("'", x$x, "'")
  query <- paste0(column, " eq ", values)
  paste(query, collapse = " or ")
}

#as.character(column_eq(c("NL01", "GM003"),"RegioS"))

# as.character(column_contains("kw"))
# as.character(column_startswith("kw"))

#resolve_deeplink("https://opendata.cbs.nl/statline/#/CBS/nl/dataset/83913NED/table?dl=32399")

#get_query(Perioden = eq("2019JJ00") | has_substring("KW", "JJ"), RegioS = c("GM0003","NL01"))
