if (interactive()){
  # search for tables containing the word birth
  
  ds_en <- cbs_search("Birth", language="en")
  head(ds_en$Title, 3)
  
  # or in Dutch
  
  ds_nl <- cbs_search(c("geboorte,sterfte"), language="nl")
  head(ds_nl$Title, 3)
  
  # docs
  docs <- cbs_search(c("geboorte,sterfte"), language="nl", format="docs")
  names(docs)
  docs[1:2,]
  
  #raw 
  raw_res <- cbs_search(c("geboorte,sterfte"), language="nl", format="raw")
  raw_res
}
