\dontrun{
cbs_get_data( id      = "7196ENG"      # table id
            , Periods = "2000MM03"     # March 2000
            , CPI     = "000000"       # Category code for total 
            )

cbs_get_data( id      = "7196ENG"      # table id
            , Periods = has_substring("JJ")     # all years
            , CPI     = "000000"       # Category code for total 
            )

cbs_get_data( id      = "7196ENG"      # table id
            , Periods = c("2000MM03","2001MM03")     # March 2000 amd 2001
            , CPI     = "000000"       # Category code for total 
            )

cbs_get_data( id      = "7196ENG"      # table id
            , Periods = eq("2000MM03") | has_substring("JJ")     # March 2000 and all years
            , CPI     = "000000"       # Category code for total 
            )
}