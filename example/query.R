\dontrun{
cbs_get_data( id      = "7196ENG"      # table id
            , Periods = "2000MM03"     # March 2000
            , CPI     = "000000"       # Category code for total 
            )

# useful substrings:
## Periods: "JJ": years, "KW": quarters, "MM", months
## Regions: "NL", "PV": provinces, "GM": municipalities
  
cbs_get_data( id      = "7196ENG"      # table id
            , Periods = has_substring("JJ")     # all years
            , CPI     = "000000"       # Category code for total 
            )

cbs_get_data( id      = "7196ENG"      # table id
            , Periods = c("2000MM03","2001MM12")     # March 2000 and Dec 2001
            , CPI     = "000000"       # Category code for total 
            )

# combine either this
cbs_get_data( id      = "7196ENG"      # table id
            , Periods = has_substring("JJ") | "2000MM01" # all years and Jan 2001
            , CPI     = "000000"       # Category code for total 
            )

# or this: note the "eq" function
cbs_get_data( id      = "7196ENG"      # table id
            , Periods = eq("2000MM01") | has_substring("JJ") # Jan 2000 and all years
            , CPI     = "000000"       # Category code for total 
            )
}