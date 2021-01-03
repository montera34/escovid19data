library(tidyverse)
library(RSelenium)
# library(stringr)
library(xfun) 
library(xml2)
library(jsonlite)
#library(magrittr)
library(jsonlite)
library(XML)

#1 HOSPITALIZADOS----

url <- "https://grafcan1.maps.arcgis.com/apps/opsdashboard/index.html#/6c18fb18eae64df2a5ecca8c4bd846c3"

#Aquí abrimos un browser (puedes cambiar a "crhome" o "explorer") controlado
#remotamente desde R

mybrowser <- rsDriver(browser = "firefox")

remDr <- mybrowser[["client"]]

remDr$navigate(url)

#Le decimos a R que espere 9 segundos por si la pagina tarda en cargar
Sys.sleep(9)



dfTEST2 <- tibble()

# Un loop para descargar los datos de cada hospital
for (i in 1:23) {
  
# Le decimos al browser que haga click en un determinado elemento (el nombre del 
# hospital a la izquierda del panel), para filtrar por isla, y en el siguiente, y 
# en el siguiente, y en el siguiente...

categorykey_hosp <-remDr$findElement('xpath', paste("/html/body/div/div/div[2]/div/div/div/margin-container/full-container/div[4]/margin-container/full-container/div/div/nav/span[",i,"]", sep = ""))

categorykey_hosp$clickElement()

Sys.sleep(9)

#Descargamos el codigo de la pagina

parsed_pagesource <- remDr$getPageSource()[[1]]

hospi_name <- xml2::read_html(parsed_pagesource) %>%
  # copiamos el nombre del hospital a traves de su xpath
  rvest::html_nodes(xpath = paste("/html/body/div/div/div[2]/div/div/div/margin-container/full-container/div[4]/margin-container/full-container/div/div/nav/span[",i,"]", sep = ""))  %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("[0-9]","",.) %>% 
  gsub("\\s+", " ",.) %>%  
  trimws()


result_hospi <- xml2::read_html(parsed_pagesource) %>%
  # aquí se selscciona el tipo de elemento que se quiere extraer, el gráfico a traves de su xpath
  # Para saber la etiqueta que usar, click derecho sobre uno de los elementos,
  # dale a inspect, botón derecho y capy/full xpath
  rvest::html_nodes(xpath = "/html/body/div/div/div[2]/div/div/div/margin-container/full-container/div[15]/margin-container/full-container/div/div/div/div/div[1]/svg/g[12]") 


result_hospi2 <- result_hospi %>%
  html_nodes(css = ".amcharts-graph-bullet")


datos_hospi <- xml_attr(result_hospi2, "aria-label") %>% 
  as.data.frame() %>% 
  rename(full_label = 1) %>% 
  #filter(grepl(paste(c("Casos", "Fallecidos", "Cerrado por alta médica"), collapse="|"), full_label)) %>% 
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
  mutate(hospital = hospi_name)

dfTEST2 <- rbind(dfTEST2, datos_hospi)

}

# Cierra el browser
remDr$close()
rm(mybrowser)
gc()


# Plantilla para vincular los hospitales a las islas
labels <- tibble(
  Isla = c("Gran Canaria", "Tenerife", "Gran Canaria", "Gran Canaria", "Lanzarote", "Fuerteventura",
           "Gran Canaria", "Gran Canaria", "Lanzarote", "Gran Canaria", "Gran Canaria", "Tenerife",
           "Tenerife", "Tenerife", "Tenerife", "Tenerife", "Tenerife", "La Gomera",
           "El Hierro", "Tenerife", "Gran Canaria", "La Palma", "Tenerife"),
  hospital = c("Vithas Hospital Santa Catalina"
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
               "Hospital Insular Nuestra Señora de Los Reyes",
               "Hospital Quirón Costa Adeje",
               "Hospital Policlínico La Paloma, S.A.",
               "Hospital General de La Palma",
               "Complejo Hospitalario Universitario de Canarias")) %>% 
  select(Isla, hospital)


# Limpiamos y unimos a la plantilla hospitales-islas

output_for_esco_isla <- dfTEST2 %>% 
  left_join(labels) %>% 
  # mutate(HPT = as.character(HPT),
  #        CCR = as.character(CCR),
  #        CSR = as.character(CSR)) %>% 
  mutate(`Resto de camas hospitalarias ` = as.numeric(`Resto de camas hospitalarias `),
         `Críticas con respirador ` = as.numeric(`Críticas con respirador `),
         `Críticas sin respirador ` = as.numeric(`Críticas sin respirador `)) %>% 
  group_by(date, Isla) %>% 
  summarise(`Críticas con respirador ` = sum(`Críticas con respirador `),
            `Resto de camas hospitalarias ` = sum(`Resto de camas hospitalarias `),
            `Críticas sin respirador ` = sum(`Críticas sin respirador `)) %>% 
  ungroup() %>% 
  mutate(date = as.Date(date)) %>% 
  #filter(fecha >= "2020-11-23") %>% 
  #mutate(date = format(as.Date(date, "%d %B %Y"), "%d/%m/%Y")) %>% 
  mutate(Hospitalizados = `Resto de camas hospitalarias ` + `Críticas con respirador `+`Críticas sin respirador `,
         `UCI - Críticas con respirador` = `Críticas con respirador `,
         `UCI - Críticas sin respirador` = `Críticas sin respirador `,
         date = date) %>% 
  select(date, Isla, Hospitalizados,
         `UCI - Críticas con respirador`, `UCI - Críticas sin respirador`) %>% 
  arrange(date, match(Isla, c("Tenerife", "Gran Canaria", "Fuerteventura", "Lanzarote", "La Palma", "El Hierro", "La Gomera")))



#2 CASOS Y FALLECIDOS----

#Para extraer estos datos necesitamos un nuevo dashboard (url). 
#De nuevo debemos clickar en diferentes elementos
#del dashboard para filtrar por isla

url <- "https://grafcan1.maps.arcgis.com/apps/opsdashboard/index.html#/156eddd4d6fa4ff1987468d1fd70efb6"

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

# Cierra el browser
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
         recovered = `Cerrado por alta médica `, hospitalized = Hospitalizados) %>% 
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
  ungroup() %>% 
  mutate(province = gsub("Las Palmas", "Palmas, Las", province)) %>% 
  mutate(ine_code = case_when(
    province == "Palmas, Las" ~ "35",
    province == "Santa Cruz de Tenerife" ~ "38",
    TRUE ~ province
  ),
  ccaa = "Canarias", PCR = NA,  TestAc = NA, cases_accumulated_PCR = NA,
  source_name = "Mapa COVID Canarias ",
  source = "https://grafcan1.maps.arcgis.com/apps/opsdashboard/index.html#/156eddd4d6fa4ff1987468d1fd70efb6 , 
  https://grafcan1.maps.arcgis.com/apps/opsdashboard/index.html#/6c18fb18eae64df2a5ecca8c4bd846c3") %>% 
  group_by(province) %>% 
  arrange(date) %>% 
  mutate(cases_accumulated = as.numeric(cases_accumulated)) %>% 
  mutate(new_cases = cases_accumulated - lag(cases_accumulated),
         activos =  (cases_accumulated - deceased) - recovered) %>% 
  ungroup() %>% 
  mutate(poblacion = case_when(
    province == "Palmas, Las" ~ "1120406",
    province == "Santa Cruz de Tenerife" ~ "1032983",
    TRUE ~ province
  )) %>% 
  mutate(poblacion = as.numeric(poblacion)) %>% 
  select(date, province, ine_code, ccaa, new_cases, PCR, TestAc, hospitalized, intensive_care, 
         cases_accumulated_PCR, deceased, cases_accumulated, activos, poblacion,
         recovered, source_name, source)# %>% 
  #filter(date != max(date))


write_csv(data_full_final_islas, "canarias_islas_full.csv")  


write_csv(data_full_final_provinces, "canarias_provincias_full.csv") 





