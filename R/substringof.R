#' Find codes in colums
#' 
eq <- function(x, key = NULL){
  structure(
    list( x = x
        , key = key
        )
        , class=c("eq_query", "query")
  )
}

#' Detect substring in column `key`
#' 
#' Detects a substring in a column.
#' @param x substring to be detected in column
#' @param key column name
contains <- function(x, key = NULL){
  # if (length(x) > 1){
  #   stop("'x' needs to be a single text")
  # }
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

#' @rdname contains
#' @aliases contains
substringof <- contains

`|.query` <- function(x, y){
  if (inherits(x, "or_query")){
    res <- c(x$x,list(y))
  } else {
    res <- list(x,y)
  }
  key <- x$key
  structure( list(x = res, key = key)
           , class=c("or_query", "query")
           )
}


as.character.query <- function(x, key = x$key, ...){
  query <- sapply(x$x, function(value){
    whisker.render("{{cmd}}('{{value}}', {{key}})"
                   , list(cmd = x$cmd, value = value, key = key)
    )
  })
  paste(query, collapse = " or ")
}

as.character.or_query <- function(x, key = x$key, ...){
  query <- sapply(x$x, as.character, key = key)
  query <- paste(query, collapse = " or ")
  paste0("(", query, ")")
}

as.character.eq_query <- function(x, key = x$key, ...){
  values <- paste0("'", x$x, "'")
  query <- paste0(key, " eq ", values)
  paste(query, collapse = " or ")
}

#as.character(key_eq(c("NL01", "GM003"),"RegioS"))

# as.character(key_contains("kw"))
# as.character(key_startswith("kw"))

resolve_deeplink("https://opendata.cbs.nl/statline/#/CBS/nl/dataset/83913NED/table?dl=32399")

#get_query(Perioden = eq("2019JJ00") | contains("KW", "JJ"), RegioS = c("GM0003","NL01"))
