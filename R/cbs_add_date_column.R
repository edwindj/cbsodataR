#' Convert the time variable into either a date or numeric. 
#' 
#' Time periods in data of CBS are coded: yyyyXXww (e.g. 2018JJ00, 2018MM10, 2018KW02),
#' which contains year (yyyy), type (XX) and index (ww). `cbs_add_date_column` converts
#' these codes into a [Date()] or `numeric`. In addition it adds
#' a frequency column denoting the type of the column.
#' @param x `data.frame` retrieved using [cbs_get_data()]
#' 
#' @param date_type Type of date column: "Date", "numeric. Numeric creates a fractional 
#' number which signs the "middle" of the period. e.g. 2018JJ00 -> 2018.5 and 
#' 2018KW01 -> 2018.167. This is for the following reasons: otherwise 2018.0 could mean
#' 2018, 2018 Q1 or 2018 Jan, and furthermore 2018.75 is a bit strange for 2018 Q4. 
#' If all codes in the dataset have frequency "Y" the numeric output will be `integer`.
#' @param ... future use. 
#' @return original dataset with two added columns: `<period>_date` and 
#' `<period>_freq`. This last column is a factor with levels: `Y`, `Q` and `M`
#' @export
#' @family data retrieval
#' @family meta data
cbs_add_date_column <- function(x, date_type = c("Date", "numeric"),...){
  # retrieve period column (using timedimension)
  period_name <- names(unlist(sapply(x, attr, "is_time")))
  
  if (!length(period_name)){
    warning("No time dimension found!")
    return(x)
  }
    
  period <- x[[period_name[1]]]
  
  PATTERN <- "(\\d{4})(\\w{2})(\\d{2})"
  
  year   <- as.integer(sub(PATTERN, "\\1", period))
  number <- as.integer(sub(PATTERN, "\\3", period))
  type   <- factor(sub(PATTERN, "\\2", period))
  
  #TODO add switch for begin / middle / period or number
  
  # year conversion
  is_year <- type %in% c("JJ")
  is_quarter <- type %in% c("KW")
  is_month <- type %in% c("MM")
  
  
  # date
  date_type <- match.arg(date_type)
  
  if (date_type == "Date"){
    period <- as.POSIXct(character())
    period[is_year] <- ISOdate(year, 1, 1, tz="")[is_year]
    period[is_quarter] <- ISOdate(year, 1 + (number - 1) * 3, 1, tz="")[is_quarter]
    period[is_month] <- ISOdate(year, number, 1, tz="")[is_month]
    period <- as.Date(period)
  } else if (date_type == "numeric"){
    period <- numeric()
    period[is_year] <- year[is_year] + 0.5
    period[is_quarter] <- (year + (3*(number - 1) + 2) / 12)[is_quarter]
    period[is_month] <- (year + (number - 0.5) / 12)[is_month]
    if (all(is_year)){
      period <- as.integer(period)
    }
  }
  
  type1 <- factor(levels=c("Y","Q", "M"))
  type1[is_year] <- "Y"
  type1[is_quarter] <- "Q"
  type1[is_month] <- "M"
  type1 <- droplevels(type1)
  
  # put the column just behind the period column
  i <- which(names(x) == period_name)
  x <- x[c(1:i, i, i:ncol(x))]
  idx <- c(i+1, i+2)
  x[idx] <- list(period, type1)
  names(x)[idx] <- paste0(period_name, paste0("_", c(date_type,"freq")))
  x
}

# x <- cbs_get_data("81819NED")
# x1 <- cbs_add_date_column(x)
  
