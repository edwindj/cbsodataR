if (interactive()) {
  x <- cbs_get_data( id      = "7196ENG"      # table id
                   , Periods = "2000MM03"     # March 2000
                   , CPI     = "000000"       # Category code for total 
                   , verbose = TRUE           # show the url that is used
                   )
  
  
  # adds two extra columns
  x_with_units <- 
    x |> 
    cbs_add_unit_column()
  
  x_with_units[,1:4]
}