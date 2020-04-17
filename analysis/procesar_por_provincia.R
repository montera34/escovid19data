# Procesar datos de Coronavirus COVID-19 en España por provincia

# Load libraries -----------
library(tidyverse)
library(reshape2)

# Settings -------
# Cambia el pie del gráfico pero conserva la fuente de los datos
caption <- "Gráfico: lab.montera34.com/covid19 | Datos: Ministerio de Sanidad de España extraídos por Datadista.com"
caption_en <- "By: lab.montera34.com/covid19 | Data: ProvidencialData19. Check code.montera34.com/covid19"
caption_provincia <- "Gráfico: montera34.com | Datos: recopilado por Providencialdata19 (lab.montera34.com/covid19, bit.ly/amadrinaunaccaa)"
period <- "2020.02.27 - 04.15"
filter_date <- as.Date("2020-04-16")

# Load Data ---------
# / Population -------------
provincias_poblacion <-  read.delim("data/original/provincias-poblacion.csv",sep = ",")

# / COVID-19 in Spain -----------
# / By province -----------
# Downloaded data from https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=0
data_cases_sp_provinces <- read.delim("data/original/covid19_spain_provincias.csv",sep = ",")

# Process data ------
# Create date variable
data_cases_sp_provinces$date  <- as.Date(data_cases_sp_provinces$date)

# Agreggate Canary islands -------
canarias <- data_cases_sp_provinces %>% filter( ccaa == "Canarias")
names(canarias)
# Group by province
tenerife <- canarias %>% filter(province == "La Gomera" | province =="La Palma" | province == "Tenerife" | province == "El Hierro") %>% group_by(date) %>% summarise(
  province = "Santa, Cruz de Tenerife",
  ccaa = "Canarias",
  new_cases = sum(new_cases),
  activos = sum(activos),
  hospitalized = sum(hospitalized),
  intensive_care = sum(intensive_care),
  deceased = sum(deceased),
  cases_accumulated = sum(cases_accumulated),
  recovered = sum(recovered),
  source = paste(source, collapse = ";"),
  comments = paste(comments, collapse = ";")
)
palmas <- canarias %>% filter(province == "Fuerteventura" | province =="Lanzarote" | province == "Gran Canaria") %>% group_by(date) %>% summarise(
  province = "Palmas, Las",
  ccaa = "Canarias",
  new_cases = sum(new_cases),
  activos = sum(activos),
  hospitalized = sum(hospitalized),
  intensive_care = sum(intensive_care),
  deceased = sum(deceased),
  cases_accumulated = sum(cases_accumulated),
  recovered = sum(recovered),
  source = paste(source, collapse = ";"),
  comments = paste(comments, collapse = ";")
)

# bind Palmas and Tenerife
canarias_bind <- rbind(tenerife,palmas)

# Remove Canarias and adds it as provinces
data_cases_sp_provinces <-  data_cases_sp_provinces %>% filter( ccaa != "Canarias")
# Add Canarias
data_cases_sp_provinces <- rbind(data_cases_sp_provinces,canarias_bind)

# Remove last -usually incomplete- day
data_cases_sp_provinces <- filter(data_cases_sp_provinces, !is.na(date))
data_cases_sp_provinces <- data_cases_sp_provinces %>% filter( date != filter_date) %>% arrange(date)

# Add missin Barcelona data -------- 
# # Do not use as data have been hasd coded in the original data
# #  select all the cataluña provinces (Barcelona is not available) to calculate how many deaths
# prov_cat <- data_cases_sp_provinces %>% filter( ccaa == "Cataluña" & province != "Barcelona"  & date > as.Date("2020-03-08") ) %>%
#   group_by(date ) %>% summarise( tot_menos_bc = sum(deceased, na.rm = TRUE) )
# prov_cat$date
# # selects dates of DAtadista database for Cataluña region
# catalunya_datadista <- data_all_export %>% filter( region == "Cataluña" & date > as.Date("2020-03-08") &  date < as.Date("2020-04-13") ) %>%
#   select(date,deceassed)
# catalunya_datadista$date
# # insert Cataluña deaths bu Barcelona
# catalunya_datadista$tot_menos_bcn <- prov_cat$tot_menos_bc
# catalunya_datadista <- as.data.frame(catalunya_datadista)
# # calculates Barcelona deaths
# catalunya_datadista$deaths_bcn <- catalunya_datadista$deceassed - catalunya_datadista$tot_menos_bc
# catalunya_datadista$province <- "Barcelona"
# 
# # compare dates to see they are the same
# catalunya_datadista[catalunya_datadista$date > as.Date("2020-03-05") &
#                       catalunya_datadista$date < as.Date("2020-04-13") ,]$date
# data_cases_sp_provinces[  ( data_cases_sp_provinces$date > min(catalunya_datadista$date +2 ) ) &
#                             ( data_cases_sp_provinces$date < as.Date("2020-04-13") ) &
#                             data_cases_sp_provinces$province == "Barcelona", ]$date
# 
# # inserts Barcelona deaths
# data_cases_sp_provinces[  ( data_cases_sp_provinces$date > min(catalunya_datadista$date +2 ) ) &
#                             ( data_cases_sp_provinces$date < as.Date("2020-04-13") ) &
#                             data_cases_sp_provinces$province == "Barcelona", ]$deceased <- catalunya_datadista[catalunya_datadista$date > as.Date("2020-03-05") &
#                                                                                                                  catalunya_datadista$date < as.Date("2020-04-13") ,]$deaths_bcn

# add population data -----
data_cases_sp_provinces <- merge( data_cases_sp_provinces, select(provincias_poblacion,provincia,poblacion,ine_code), by.x = "province", by.y = "provincia", all = TRUE   )

# calculate values per 
data_cases_sp_provinces$cases_per_cienmil <- round( data_cases_sp_provinces$cases_accumulated / data_cases_sp_provinces$poblacion * 100000, digits = 2)
data_cases_sp_provinces$intensive_care_per_1000000 <- round( data_cases_sp_provinces$intensive_care / data_cases_sp_provinces$poblacion * 100000, digits = 2)
data_cases_sp_provinces$deceassed_per_100000 <- round( data_cases_sp_provinces$deceased / data_cases_sp_provinces$poblacion * 100000, digits = 2)

# Calculates daily deaths
data_cases_sp_provinces <- data_cases_sp_provinces %>% 
  group_by(province) %>% arrange(date) %>% 
  mutate( daily_deaths = deceased - lag(deceased),
          daily_deaths_inc = round((deceased - lag(deceased)) /lag(deceased) * 100, digits = 1),
          daily_deaths_avg3 =  round( ( daily_deaths + lag(daily_deaths,1)+lag(daily_deaths,2) ) / 3, digits = 1 ), # average of daily deaths of 3 last days
          daily_deaths_avg6 =  round( ( daily_deaths + lag(daily_deaths,1)+lag(daily_deaths,2)+
                                          lag(daily_deaths,3)+lag(daily_deaths,4)+lag(daily_deaths,5) ) / 6, digits = 1 ),  # average of dayly deaths of 6 last days
          deaths_cum_last_week = ( deceased + lag(deceased,1) + lag(deceased,2) + lag(deceased,3) + lag(deceased,4) + lag(deceased,5) + lag(deceased,6) ) / 7,  
          deaths_last_week =  daily_deaths + lag(daily_deaths,1) + lag(daily_deaths,2) + lag(daily_deaths,3) + lag(daily_deaths,4) + lag(daily_deaths,5) + lag(daily_deaths,6)  
  )

data_cases_sp_provinces <- data_cases_sp_provinces %>% select(date,province,ine_code,everything()) %>%
  select(-source,-comments,source,comments)

write.csv(data_cases_sp_provinces, file = "data/output/covid19-provincias-spain_consolidated.csv", row.names = FALSE)