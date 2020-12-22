library(tidyverse)
library(RSelenium)
# library(stringr)
library(xfun) 
library(xml2)
library(jsonlite)
#library(magrittr)
library(jsonlite)
library(XML)

#----EXTRAER SERIE DATOS POR HOSPITAL, PROVINCIA E ISLA----


# En este caso la dificultad es encontrar el link. Para ello hay que inspeccionar la pagina,
# ir a Network en la consola, actualizar la pagina y buscar el link con la "query" que necesitamos.
# Para identificarlo hay que mirar los campos de cada query. En este caso nos interesan 
# OID, CCV19, FECHA y SERIE (también aparacen en el link)
# data <- jsonlite::read_json('https://services9.arcgis.com/CgZpnNiCwFObjaOT/arcgis/rest/services/CentrosSanitarios/FeatureServer/1/query?f=json&where=1%3D1&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=OID%2CCV19%2CFECHA%2CSERIE&orderByFields=FECHA%20asc&resultOffset=0&resultRecordCount=32000&resultType=standard&cacheHint=true') %>%
#   .$features


tmp <- tempfile()
url <- "https://services9.arcgis.com/CgZpnNiCwFObjaOT/arcgis/rest/services/CentrosSanitarios/FeatureServer/1/query?f=json&where=1%3D1&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=OID%2CCV19%2CFECHA%2CSERIE&orderByFields=FECHA%20asc&resultOffset=0&resultRecordCount=32000&resultType=standard&cacheHint=true"
download.file(url, destfile =tmp,quiet = FALSE, mode = "w")
df <- jsonlite::fromJSON(tmp)



df <- df[["features"]][["attributes"]]

dfTEST2 <- df %>% 
  mutate(FECHA = as.character(FECHA)) %>% 
  mutate(numero = as.numeric(FECHA)) %>% 
  mutate(date = as.POSIXct(`numero`/1000, origin="1970-01-01")) %>% 
  group_by(SERIE, date) %>% 
  # añadimos un ID para cada hospital, aunque aun no sabemos cual es cual
  mutate(ID = row_number()) %>% 
  ungroup() %>% 
  select(-OID, -FECHA, -numero) %>% 
  spread(SERIE, CV19)

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
               "Complejo Hospitalario Universitario de Canarias")) %>% 
  select(Isla, Hospital, ID)




output_for_esco_isla <- dfTEST2 %>% 
  left_join(labels) %>% 
  mutate(HPT = as.character(HPT),
         CCR = as.character(CCR),
         CSR = as.character(CSR)) %>% 
  mutate(HPT = as.numeric(HPT),
         CCR = as.numeric(CCR),
         CSR = as.numeric(CSR)) %>% 
  group_by(date, Isla) %>% 
  summarise(CCR = sum(CCR),
            HPT = sum(HPT),
            CSR = sum(CSR)) %>% 
  ungroup() %>% 
  mutate(date = as.Date(date)) %>% 
  #filter(fecha >= "2020-11-23") %>% 
  #mutate(date = format(as.Date(date, "%d %B %Y"), "%d/%m/%Y")) %>% 
  rename(Hispitalizados = HPT,
         `UCI - Críticas con respirador` = CCR,
         `UCI - Críticas sin respirador` = CSR,
         date = date) %>% 
  select(date, Isla, Hispitalizados,
         `UCI - Críticas con respirador`, `UCI - Críticas sin respirador`) %>% 
  arrange(date, match(Isla, c("Tenerife", "Gran Canaria", "Fuerteventura", "Lanzarote", "La Palma", "El Hierro", "La Gomera")))



#2 CASOS Y FALLECIDOS----

#Para extraer estos datos necesitamos un nuevo dashboard (url). Además, en este
#caso es un poco más complicado puesto que debemos clickar en diferentes elementos
#del dashboard para filtrar por isla

url <- "https://datacovid.salud.aragon.es/covid/"

#Aquí abrimos un browser (puedes cambiar a "crhome" o "explorer") controlado
#remotamente desde R

mybrowser <- rsDriver(browser = "firefox")

remDr <- mybrowser[["client"]]

remDr$navigate(url)

#Le decimos a R que espere 9 segundos por si la pagina tarda en cargar
Sys.sleep(9)

#2.1 TENERIFE----

#Le decimos al browser que haga click en un determinado elemento (el nombre de 
# Tenerife a la izquierda del panel), para filtrar por isla

categorykey_prov <-remDr$findElement('xpath', '/html/body/div/div/div[2]/div/div/div/margin-container/full-container/div[7]/margin-container/full-container/div/div[2]/nav/span[1]/div')

categorykey_prov$clickElement()

Sys.sleep(9)

#Descargamos el codigo de la pagina

parsed_pagesource <- remDr$getPageSource()[[1]]


result_tenerife <- xml2::read_html(parsed_pagesource) %>%
  # aquí se selscciona el tipo de elemento que se quiere extraer, en este caso los "bullet-poits"
  # del gáfico de lineas. Para saber la etiqueta que usar, click derecho sobre uno de los elementos,
  # dale a inspect y buxca la clase (class =) del objeto
  rvest::html_nodes(css = ".amcharts-graph-bullet") 

datos_tenerife <- xml_attr(result_tenerife, "aria-label") %>% 
  as.data.frame() %>% 
  rename(full_label = 1) %>% 
  filter(grepl(paste(c("Casos", "Fallecidos", "Cerrado por alta médica"), collapse="|"), full_label)) %>% 
  mutate(value = sub(".*\\s", '', full_label)) %>% 
  mutate(full_label = gsub("\\s+[^ ]+$", '', full_label)) %>% 
  mutate(date = str_sub(full_label,-12,-1)) %>% 
  mutate(label_clean = str_sub(full_label,1,-13)) %>% 
  select(-full_label) %>% 
  group_by(date, label_clean) %>% 
  slice(1L) %>% 
  spread(label_clean, value) %>% 
  mutate(date = gsub(",","",date)) %>% 
  mutate(date = as.Date(date, format = "%B %d %Y")) %>% 
  mutate(Isla = "Tenerife")


#2.2 GRAN CANARIA----


categorykey_prov <-remDr$findElement('xpath', '/html/body/div/div/div[2]/div/div/div/margin-container/full-container/div[7]/margin-container/full-container/div/div[2]/nav/span[2]')

categorykey_prov$clickElement()

Sys.sleep(9)


parsed_pagesource <- remDr$getPageSource()[[1]]


result_grancanaria <- xml2::read_html(parsed_pagesource) %>%
  rvest::html_nodes(css = ".amcharts-graph-bullet") 

datos_grancanaria <- xml_attr(result_grancanaria, "aria-label") %>% 
  as.data.frame() %>% 
  rename(full_label = 1) %>% 
  filter(grepl(paste(c("Casos", "Fallecidos", "Cerrado por alta médica"), collapse="|"), full_label)) %>% 
  mutate(value = sub(".*\\s", '', full_label)) %>% 
  mutate(full_label = gsub("\\s+[^ ]+$", '', full_label)) %>% 
  mutate(date = str_sub(full_label,-12,-1)) %>% 
  mutate(label_clean = str_sub(full_label,1,-13)) %>% 
  select(-full_label) %>% 
  group_by(date, label_clean) %>% 
  slice(1L) %>% 
  spread(label_clean, value) %>% 
  mutate(date = gsub(",","",date)) %>% 
  mutate(date = as.Date(date, format = "%B %d %Y")) %>% 
  mutate(Isla = "Gran Canaria")



#2.3 LANZAROTE----

categorykey_prov <-remDr$findElement('xpath', '/html/body/div/div/div[2]/div/div/div/margin-container/full-container/div[7]/margin-container/full-container/div/div[2]/nav/span[3]')

categorykey_prov$clickElement()

Sys.sleep(9)


parsed_pagesource <- remDr$getPageSource()[[1]]


result_lanzarote <- xml2::read_html(parsed_pagesource) %>%
  rvest::html_nodes(css = ".amcharts-graph-bullet") 

datos_lanzarote <- xml_attr(result_lanzarote, "aria-label") %>% 
  as.data.frame() %>% 
  rename(full_label = 1) %>% 
  filter(grepl(paste(c("Casos", "Fallecidos", "Cerrado por alta médica"), collapse="|"), full_label)) %>% 
  mutate(value = sub(".*\\s", '', full_label)) %>% 
  mutate(full_label = gsub("\\s+[^ ]+$", '', full_label)) %>% 
  mutate(date = str_sub(full_label,-12,-1)) %>% 
  mutate(label_clean = str_sub(full_label,1,-13)) %>% 
  select(-full_label) %>% 
  group_by(date, label_clean) %>% 
  slice(1L) %>% 
  spread(label_clean, value) %>% 
  mutate(date = gsub(",","",date)) %>% 
  mutate(date = as.Date(date, format = "%B %d %Y")) %>% 
  mutate(Isla = "Lanzarote")


#2.4 FUERTEVENTURA----

categorykey_prov <-remDr$findElement('xpath', '/html/body/div/div/div[2]/div/div/div/margin-container/full-container/div[7]/margin-container/full-container/div/div[2]/nav/span[4]')

categorykey_prov$clickElement()

Sys.sleep(9)


parsed_pagesource <- remDr$getPageSource()[[1]]


result_fuerteventura <- xml2::read_html(parsed_pagesource) %>%
  rvest::html_nodes(css = ".amcharts-graph-bullet") 

datos_fuerteventura <- xml_attr(result_fuerteventura, "aria-label") %>% 
  as.data.frame() %>% 
  rename(full_label = 1) %>% 
  filter(grepl(paste(c("Casos", "Fallecidos", "Cerrado por alta médica"), collapse="|"), full_label)) %>% 
  mutate(value = sub(".*\\s", '', full_label)) %>% 
  mutate(full_label = gsub("\\s+[^ ]+$", '', full_label)) %>% 
  mutate(date = str_sub(full_label,-12,-1)) %>% 
  mutate(label_clean = str_sub(full_label,1,-13)) %>% 
  select(-full_label) %>% 
  group_by(date, label_clean) %>% 
  slice(1L) %>% 
  spread(label_clean, value) %>% 
  mutate(date = gsub(",","",date)) %>% 
  mutate(date = as.Date(date, format = "%B %d %Y")) %>% 
  mutate(Isla = "Fuerteventura")



#2.5 LA PALMA----


categorykey_prov <-remDr$findElement('xpath', '/html/body/div/div/div[2]/div/div/div/margin-container/full-container/div[7]/margin-container/full-container/div/div[2]/nav/span[5]')

categorykey_prov$clickElement()

Sys.sleep(9)


parsed_pagesource <- remDr$getPageSource()[[1]]


result_lapama <- xml2::read_html(parsed_pagesource) %>%
  rvest::html_nodes(css = ".amcharts-graph-bullet") 

datos_lapalma <- xml_attr(result_lapama, "aria-label") %>% 
  as.data.frame() %>% 
  rename(full_label = 1) %>% 
  filter(grepl(paste(c("Casos", "Fallecidos", "Cerrado por alta médica"), collapse="|"), full_label)) %>% 
  mutate(value = sub(".*\\s", '', full_label)) %>% 
  mutate(full_label = gsub("\\s+[^ ]+$", '', full_label)) %>% 
  mutate(date = str_sub(full_label,-12,-1)) %>% 
  mutate(label_clean = str_sub(full_label,1,-13)) %>% 
  select(-full_label) %>% 
  group_by(date, label_clean) %>% 
  slice(1L) %>% 
  spread(label_clean, value) %>% 
  mutate(date = gsub(",","",date)) %>% 
  mutate(date = as.Date(date, format = "%B %d %Y")) %>% 
  mutate(Isla = "La Palma")



#2.6 LA GOMERA----

categorykey_prov <-remDr$findElement('xpath', '/html/body/div/div/div[2]/div/div/div/margin-container/full-container/div[7]/margin-container/full-container/div/div[2]/nav/span[6]')

categorykey_prov$clickElement()

Sys.sleep(9)


parsed_pagesource <- remDr$getPageSource()[[1]]


result_lagomera <- xml2::read_html(parsed_pagesource) %>%
  rvest::html_nodes(css = ".amcharts-graph-bullet") 

datos_lagomera <- xml_attr(result_lagomera, "aria-label") %>% 
  as.data.frame() %>% 
  rename(full_label = 1) %>% 
  filter(grepl(paste(c("Casos", "Fallecidos", "Cerrado por alta médica"), collapse="|"), full_label)) %>% 
  mutate(value = sub(".*\\s", '', full_label)) %>% 
  mutate(full_label = gsub("\\s+[^ ]+$", '', full_label)) %>% 
  mutate(date = str_sub(full_label,-12,-1)) %>% 
  mutate(label_clean = str_sub(full_label,1,-13)) %>% 
  select(-full_label) %>% 
  group_by(date, label_clean) %>% 
  slice(1L) %>% 
  spread(label_clean, value) %>% 
  mutate(date = gsub(",","",date)) %>% 
  mutate(date = as.Date(date, format = "%B %d %Y")) %>% 
  mutate(Isla = "La Gomera")



#2.7 El HIERRO----


categorykey_prov <-remDr$findElement('xpath', '/html/body/div/div/div[2]/div/div/div/margin-container/full-container/div[7]/margin-container/full-container/div/div[2]/nav/span[7]')

categorykey_prov$clickElement()

Sys.sleep(9)


parsed_pagesource <- remDr$getPageSource()[[1]]


result_elhierro <- xml2::read_html(parsed_pagesource) %>%
  rvest::html_nodes(css = ".amcharts-graph-bullet") 

datos_elhierro <- xml_attr(result_elhierro, "aria-label") %>% 
  as.data.frame() %>% 
  rename(full_label = 1) %>% 
  filter(grepl(paste(c("Casos", "Fallecidos", "Cerrado por alta médica"), collapse="|"), full_label)) %>% 
  mutate(value = sub(".*\\s", '', full_label)) %>% 
  mutate(full_label = gsub("\\s+[^ ]+$", '', full_label)) %>% 
  mutate(date = str_sub(full_label,-12,-1)) %>% 
  mutate(label_clean = str_sub(full_label,1,-13)) %>% 
  select(-full_label) %>% 
  group_by(date, label_clean) %>% 
  slice(1L) %>% 
  spread(label_clean, value) %>% 
  mutate(date = gsub(",","",date)) %>% 
  mutate(date = as.Date(date, format = "%B %d %Y")) %>% 
  mutate(Isla = "El Hierro")

# Cierra el growser
remDr$close()
rm(mybrowser)
gc()



casos_islas <- rbind(datos_elhierro, datos_fuerteventura, datos_grancanaria,
                     datos_lagomera, datos_lanzarote, datos_lapalma,
                     datos_tenerife)


#3 UNIFICANDO----

labels_isla_province <- tibble(
  Isla = c("Gran Canaria", "Tenerife", "Gran Canaria", "Gran Canaria", "Lanzarote", "Fuerteventura",
           "Gran Canaria", "Gran Canaria", "Lanzarote", "Gran Canaria", "Gran Canaria", "Tenerife",
           "Tenerife", "Tenerife", "Tenerife", "Tenerife", "Tenerife", "La Gomera",
           "El Hierro", "Tenerife", "Gran Canaria", "La Palma", "Tenerife"),
  province = c("Las Palmas", "Santa Cruz de Tenerife", "Las Palmas",
               "Las Palmas", "Las Palmas", "Las Palmas",
               "Las Palmas", "Las Palmas", "Las Palmas",
               "Las Palmas", "Las Palmas", "Santa Cruz de Tenerife",
               "Santa Cruz de Tenerife", "Santa Cruz de Tenerife", "Santa Cruz de Tenerife",
               "Santa Cruz de Tenerife", "Santa Cruz de Tenerife", "Santa Cruz de Tenerife",
               "Santa Cruz de Tenerife", "Santa Cruz de Tenerife", "Las Palmas",
               "Santa Cruz de Tenerife", "Santa Cruz de Tenerife")) %>% 
  select(Isla, province)


# Unificamos y hacemos un par de cambios para el output final

data_full_final_islas <- casos_islas %>% 
  left_join(output_for_esco_isla) %>% 
  mutate(intensive_care = `UCI - Críticas con respirador` + `UCI - Críticas sin respirador`) %>% 
  select(-`UCI - Críticas sin respirador`, -`UCI - Críticas con respirador`) %>% 
  rename(cases_accumulated = `Casos `, deceased = `Fallecidos `,
         recovered = `Cerrado por alta médica `, hospitalized = Hispitalizados) %>% 
  mutate(cases_accumulated = gsub(",","",cases_accumulated),
         deceased = gsub(",","",deceased),
         recovered = gsub(",","",recovered)) %>% 
  mutate(cases_accumulated = as.numeric(cases_accumulated),
         deceased = as.numeric(deceased),
         recovered = as.numeric(recovered))


data_full_final_provinces <- data_full_final_islas %>% 
  left_join(labels_isla_province) %>% 
  unique() %>% 
  group_by(date, province) %>% 
  summarise(cases_accumulated = sum(cases_accumulated),
            deceased = sum(deceased),
            recovered = sum(recovered),
            hospitalized = sum(hospitalized),
            intensive_care = sum(intensive_care)) %>% 
  ungroup()


write_csv(data_full_final_islas, "canarias_islas_full.csv")  


write_csv(data_full_final_provinces, "canarias_provincias_full.csv") 





