id <- '80302ned'

library(cbsodataR)
meta <- cbs_get_meta(id,verbose=TRUE,cache=TRUE)
View(meta$Voertuigtypes)
View(meta$Perioden)
data <- cbs_get_data(id)
View(data)

# Voeg de metadata toe aan de data zelf
data2 <- cbs_add_label_columns(data)
View(data2)
# werkt wel bij jaar maar niet bij voertuigtype
# in de data is voertuigtype een getal en in de metadata een string b.v. 0 en '00', mogelijk is dat de oorzaak?
# expliciet benoemen helpt ook niet
data2 <- cbs_add_label_columns(data,columns = 'Voertuigtypes')
