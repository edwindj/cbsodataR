\dontrun{
x <- cbs_get_data( id      = "7196ENG"      # table id
                 , Periods = "2000MM03"     # March 2000
                 , CPI     = "000000"       # Category code for total 
                 )

# add a Periods_Date column
x <- cbs_add_date_column(x)
x

# add a Periods_numeric column
x <- cbs_add_date_column(x, date_type = "numeric")
x
}