if (interactive()){
  # retrieve the datasets in the "CBS" catalog
  ds <- cbs_get_datasets()
  ds[1:5, c("Identifier", "ShortTitle")]
  
  # retrieve de datasets in the "AZW" catalog
  ds_azw <- cbs_get_datasets(catalog = "AZW")
  
  # to retrieve all datasets of all catalogs, supply "NULL"
  ds_all <- cbs_get_datasets(catalog = NULL)
}