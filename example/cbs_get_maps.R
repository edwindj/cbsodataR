if (interactive()){
  
  # retrieve maps
  cbs_maps <- cbs_get_maps()
  cbs_maps |> head(4)
  
  gemeente_map <- cbs_get_sf("gemeente", 2023, verbose=TRUE)
  
  # sf object
  gemeente_map
  
  # senseless plot
  plot(gemeente_map, max.plot = 1)
}