key_eq <- function(x, key = NULL){
  values <- paste0("'", x, "'")
  query <- paste0(key, " eq ", values)
  structure(as.list(query), class=c("or_query", "query"))
}

#' Detect substring in column `key`
#' 
#' Detects a substring in a column.
#' @export
#' @param x substring to be detected in column
#' @param key column name
key_contains <- function(x, key = NULL){
  if (length(x) > 1){
    stop("'x' needs to be a single text")
  }
  structure(
    list( x = x
        , key = key
        , cmd = "substringof"
        ),
    class = "query"
  )
}

key_startswith <- function(x, key){
  if (length(x) > 1){
    stop("'x' needs to be a single text")
  }
  structure(
    list( x = x
        , key = key
        , cmd = "startswith"
    ),
    class = "query"
  )
}

is_query <- function(x){
  inherits(x, "query")
}

#' @export
#' @rdname key_contains
#' @aliases key_contains
substringof <- key_contains

`|.query` <- function(x, y){
  if (inherits(x, "or_query")){
    res <- c(x,list(y))
  } else {
    res <- list(x,y)
  }
  structure(res, class=c("or_query", "query"))
}


as.character.query <- function(x, ...){
  whisker.render("{{cmd}}('{{x}}', {{key}})"
                , list(cmd = x$cmd, x = x$x, key = x$key)
                )
}

as.character.or_query <- function(x, ...){
  query <- sapply(x, as.character)
  query <- paste(query, collapse = " or ")
  paste0("(", query, ")")
}

#as.character(key_eq(c("NL01", "GM003"),"RegioS"))

# as.character(key_contains("kw"))
# as.character(key_startswith("kw"))

#resolve_deeplink("https://opendata.cbs.nl/statline/#/CBS/nl/dataset/83913NED/table?dl=32399")
