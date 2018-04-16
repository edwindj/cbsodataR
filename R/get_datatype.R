# utility class for retrieving data types of data
get_datatype <- function(meta){
  # this is just to keep R CMD check silent
  Datatype <- meta$DataProperties$Datatype
  
  dp <- subset(meta$DataProperties, !is.na(Datatype), c(Position,Datatype))
  dp$Position <- dp$Position + 1
  dp$Datatype[dp$Datatype %in% c("Float","Double")] = "numeric"
  dp$Datatype[dp$Datatype %in% c("Integer","Integer32", "Integer64")] = "integer"
  
  m <- max(meta$DataProperties$Position, na.rm = TRUE)
  types <- rep("character", m)
  types[dp$Position] <- dp$Datatype
  
  types
}
