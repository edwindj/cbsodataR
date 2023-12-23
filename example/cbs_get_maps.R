if (interactive()){
  
  # retrieve maps
  cbs_maps <- cbs_get_maps()
  cbs_maps |> head(4)
  
  gemeente_map <- cbs_get_sf("gemeente", 2023, verbose=TRUE)
  
  # sf object
  gemeente_map
  
  # plot the statcodes (included in the map)
  plot(gemeente_map, max.plot = 1)
  
  # now connect with some data
  labor <- cbs_get_data("85268NED"
                       , Perioden = "2022JJ00" # only 2022
                       , RegioS = has_substring("PV") # only province
                       , verbose = TRUE
                       )
  
  # most conveniently
  provincie_2022_with_data <- cbs_join_sf_with_data("provincie", 2022, labor)
  
  # better plotting options are ggplot2 or tmap, 
  # but keeping dependencies low...
  provincie_2022_with_data |> 
    subset(select = Werkloosheidspercentage_13) |> 
    plot( border ="#FFFFFF99", main="unemployment rate")
  
  ## but of course this can also be done by hand:
  labor <- labor |> 
    cbs_add_statcode_column()  # add column to connect with map
  
  provincie_2022 <- cbs_get_sf("provincie", 2022)
  
  # this is a left_join(provincie_2022, labor, by = "statcode")
  provincie_2022_data <- 
    within(provincie_2022, {
      unemployment_rate <- labor$Werkloosheidspercentage_13[match(statcode, labor$statcode)]
    }) 
  
  # better plotting options are ggplot2 or tmap, 
  # but keeping dependencies low...
  plot( provincie_2022_data[,c("unemployment_rate")]
      , border ="#FFFFFF99"
      , nbreaks = 12
      )
}