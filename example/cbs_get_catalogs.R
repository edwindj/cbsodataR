if (interactive()){
catalogs <- cbs_get_catalogs()

# Identifier of catalog can be used to query
print(catalogs$Identifier)


ds_rivm <- cbs_get_datasets(catalog = "RIVM")
ds_rivm[1:5, c("Identifier","ShortTitle")]
}