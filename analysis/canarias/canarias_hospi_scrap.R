library(tidyverse)
library(RSelenium)
# library(stringr)
library(xfun) 
library(xml2)
library(jsonlite)
#library(magrittr)
library(jsonlite)




#----EXTRAER SERIE DATOS PARA TODA LA COMUNIDAD (gráfico de lineas)----
 #url de la pagina
url <- "https://grafcan1.maps.arcgis.com/apps/opsdashboard/index.html#/6c18fb18eae64df2a5ecca8c4bd846c3"


rD <- RSelenium::rsDriver(browser="firefox",
                          extraCapabilities = list("moz:firefoxOptions" = list(
                            args = list('--headless')))
)



remDr <- rD[["client"]]

remDr$navigate(url)




parsed_pagesource <- remDr$getPageSource()[[1]]


remDr$close()

rD$server$stop()

#  Si ves este error:
#--------------------------------------------------------------------
#  Error in wdman::selenium(port = port, verbose = verbose, version = version,  : 
#  Selenium server signals port = 4567 is already in use.
#---------------------------------------------------------------------
# usa esto:
# remDr$close()
# rm(rD)
# gc()

result <- xml2::read_html(parsed_pagesource) %>%
  # aquí se selscciona el tipo de elemento que se quiere extraer, en este caso los "bullet-poits"
  # del gáfico de lineas. Para saber la etiqueta que usar, click derecho sobre uno de los elementos,
  # dale a inspect y buxca la clase (class =) del objeto
  rvest::html_nodes(css = ".amcharts-graph-bullet") 



# examinamos la lista "result" y vemos que el attribute que nos interesa es "aria-label"
datosCCAA <- xml_attr(result, "aria-label") %>% 
  as.data.frame() %>% 
  rename(full_label = 1) %>% 
  mutate(value = sub(".*\\s", '', full_label)) %>% 
  mutate(full_label = gsub("\\s+[^ ]+$", '', full_label)) %>% 
  mutate(date = str_sub(full_label,-12,-1)) %>% 
  mutate(label_clean = str_sub(full_label,1,-13)) %>% 
  select(-full_label) %>% 
  group_by(date, label_clean) %>% 
  slice(1L) %>% 
  spread(label_clean, value) %>% 
  mutate(date = gsub(",","",date)) %>% 
  mutate(date = as.Date(date, format = "%B %d %Y"))




#library(magrittr)

#----EXTRAER SERIE DATOS POR HOSPITAL, PROVINCIA E ISLA


# En este caso la dificultad es encontrar el link. Para ello hay que inspeccionar la pagina,
# ir a Network en la consola, actualizar la pagina y buscar el link con la "query" que necesitamos.
# Para identificarlo hay que mirar los campos de cada query. En este caso nos interesan 
# OID, CCV19, FECHA y SERIE (también aparacen en el link)
data <- jsonlite::read_json('https://services9.arcgis.com/CgZpnNiCwFObjaOT/arcgis/rest/services/CentrosSanitarios/FeatureServer/1/query?f=json&where=1%3D1&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=OID%2CCV19%2CFECHA%2CSERIE&orderByFields=FECHA%20asc&resultOffset=0&resultRecordCount=32000&resultType=standard&cacheHint=true') %>%
  .$features


df <- data.frame(matrix(unlist(data), nrow=length(data), byrow=T))


dfTEST2 <- df %>% 
  mutate(X3 = as.character(X3)) %>% 
  mutate(numero = as.numeric(X3)) %>% 
  mutate(fecha = as.POSIXct(`numero`/1000, origin="1970-01-01")) %>% 
  group_by(X4, fecha) %>% 
  # añadimos un ID para cada hospital, aunque aun no sabemos cual es cual
  mutate(ID = row_number()) %>% 
  ungroup() %>% 
  select(-X1, -X3, -numero) %>% 
  spread(X4, X2)

# Como no hay un ID único para cada hospital, hay que deducir cual es cual en base a los datos
# previamente recopilados y mirando los campos CCR CSR y HPT. Esto conviene revisarlo periodicamente
# pues nuestra única guia es el orden en que aparecen los Hospitales y podría cambiar
labels <- tibble(
  ID = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23),
  Isla = c("Gran Canaria", "Tenerife", "Gran Canaria", "Gran Canaria", "Lanzarote", "Fuerteventura",
                           "Gran Canaria", "Gran Canaria", "Lanzarote", "Gran Canaria", "Gran Canaria", "Tenerife",
                           "Tenerife", "Tenerife", "Tenerife", "Tenerife", "Tenerife", "La Gomera",
                           "El Hierro", "Tenerife", "Gran Canaria", "La Palma", "Tenerife"),
  Hospital = c("Vithas Hospital Santa Catalina"
                               , "RAMBLA", "Hospital San Roque Las Palmas de Gran Canaria",
                               "Hospital Nuestra Señora del Perpetuo Socorro",
                               "Hospital Dr. José Molina Orosa",
                               "Hospital General de Fuerteventura",
                               "Complejo Hospitalario Universitario Insular - Materno Infantil",
                               "Hospital Clínica Roca (Roca Gestión Hospitalaria)",
                               "Hospiten Lanzarote (Clínicas del Sur S.U.L.)",
                               "Complejo Hospitalario Universitario de Gran Canaria Dr. Negrín",
                               "Hospital San Roque Maspalomas",
                               "Complejo Hospitalario Universitario Nuestra Señora de Candelaria",
                               "Hospital San Juan de Dios", "Hospital Quirón Tenerife",
                               "Clínica Parque, S.A.", "Hospiten Sur", "Hospiten Bellevue",
                               "Hospital Nuestra Señora de Guadalupe",
                               "Hospital Insular Nuestra Señora de los Reyes",
                               "Hospital Quirón Costa Adeje",
                               "Hospital Policlínico La Paloma, S.A.",
                               "Hospital General de La Palma",
                               "Complejo Hospitalario Universitario de Canarias"),
  Provincia = c("Las Palmas", "Santa Cruz de Tenerife", "Las Palmas",
                                "Las Palmas", "Las Palmas", "Las Palmas",
                                "Las Palmas", "Las Palmas", "Las Palmas",
                                "Las Palmas", "Las Palmas", "Santa Cruz de Tenerife",
                                "Santa Cruz de Tenerife", "Santa Cruz de Tenerife", "Santa Cruz de Tenerife",
                                "Santa Cruz de Tenerife", "Santa Cruz de Tenerife", "Santa Cruz de Tenerife",
                                "Santa Cruz de Tenerife", "Santa Cruz de Tenerife", "Las Palmas",
                                "Santa Cruz de Tenerife", "Santa Cruz de Tenerife")) %>% 
  select(Isla, Provincia, Hospital, ID)

output_for_esco_hos <- dfTEST2 %>% 
  left_join(labels) %>% 
  mutate(HPT = as.character(HPT),
         CCR = as.character(CCR),
         CSR = as.character(CSR)) %>% 
  mutate(HPT = as.numeric(HPT),
         CCR = as.numeric(CCR),
         CSR = as.numeric(CSR)) %>% 
  group_by(fecha, Isla, Provincia, Hospital) %>% 
  summarise(CCR = sum(CCR),
            HPT = sum(HPT),
            CSR = sum(CSR)) %>% 
  ungroup() %>% 
  mutate(fecha = as.Date(fecha)) %>% 
  #filter(fecha >= "2020-11-23") %>% 
  mutate(fecha = format(as.Date(fecha, "%d %B %Y"), "%d/%m/%Y")) %>% 
  rename(Hispitalizados = HPT,
         `UCI - Críticas con respirador` = CCR,
         `UCI - Críticas sin respirador` = CSR,
         Fecha = fecha) %>% 
  select(Fecha, Isla, Provincia, Hospital, Hispitalizados,
         `UCI - Críticas con respirador`, `UCI - Críticas sin respirador`)



#write.csv(output_for_esco_hos, "actualiza_hospi.csv", fileEncoding = "UTF-8")



output_for_esco_isla <- dfTEST2 %>% 
  left_join(labels) %>% 
  mutate(HPT = as.character(HPT),
         CCR = as.character(CCR),
         CSR = as.character(CSR)) %>% 
  mutate(HPT = as.numeric(HPT),
         CCR = as.numeric(CCR),
         CSR = as.numeric(CSR)) %>% 
  group_by(fecha, Isla, Provincia) %>% 
  summarise(CCR = sum(CCR),
            HPT = sum(HPT),
            CSR = sum(CSR)) %>% 
  ungroup() %>% 
  mutate(fecha = as.Date(fecha)) %>% 
  #filter(fecha >= "2020-11-23") %>% 
  mutate(fecha = format(as.Date(fecha, "%d %B %Y"), "%d/%m/%Y")) %>% 
  rename(Hispitalizados = HPT,
         `UCI - Críticas con respirador` = CCR,
         `UCI - Críticas sin respirador` = CSR,
         Fecha = fecha) %>% 
  select(Fecha, Provincia, Isla, Hispitalizados,
         `UCI - Críticas con respirador`, `UCI - Críticas sin respirador`) %>% 
  arrange(Fecha, match(Isla, c("Tenerife", "Gran Canaria", "Fuerteventura", "Lanzarote", "La Palma", "El Hierro", "La Gomera")))


#write.csv(output_for_esco_isla, "actualiza_islas.csv", fileEncoding = "UTF-8")




output_for_esco_province <- dfTEST2 %>% 
  left_join(labels) %>% 
  mutate(HPT = as.character(HPT),
         CCR = as.character(CCR),
         CSR = as.character(CSR)) %>% 
  mutate(HPT = as.numeric(HPT),
         CCR = as.numeric(CCR),
         CSR = as.numeric(CSR)) %>% 
  group_by(fecha) %>% 
  summarise(CCR = sum(CCR),
            HPT = sum(HPT),
            CSR = sum(CSR)) %>% 
  ungroup() %>% 
  mutate(fecha = as.Date(fecha)) %>% 
  #filter(fecha >= "2020-11-23") %>% 
  mutate(fecha = format(as.Date(fecha, "%d %B %Y"), "%d/%m/%Y")) %>% 
  rename(Hispitalizados = HPT,
         `UCI - Críticas con respirador` = CCR,
         `UCI - Críticas sin respirador` = CSR,
         Fecha = fecha) %>% 
  select(Fecha, Hispitalizados,
         `UCI - Críticas con respirador`, `UCI - Críticas sin respirador`)

#write.csv(output_for_esco_province, "actualiza_provis.csv", fileEncoding = "UTF-8")



#---- EXTRAER DATOS POR MUNICIPIO----


# Para encontrar el siguiente link, utilizamos el link de la query (usado para hospitales) hasta 
# antes de la query (https://services9.arcgis.com/CgZpnNiCwFObjaOT/arcgis/rest/services/CentrosSanitarios/FeatureServer/)
# Este nos lleva a una epecie de backende app con todos los datos de la app. Ahí ya solo es cuestión
# de buscar el dataset que nos interesa
munidata <- jsonlite::read_json('https://services9.arcgis.com/CgZpnNiCwFObjaOT/ArcGIS/rest/services/CVCanarias/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=102100&f=json')

ww <- munidata$features
data_municipios <- data.frame(matrix(unlist(ww), nrow=length(ww), byrow=T))
colnames(data_municipios)<- c(names(ww[[1]][["attributes"]]), "x", "y")





