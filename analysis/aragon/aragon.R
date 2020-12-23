library(tidyverse)
library(RSelenium)
# library(stringr)
library(xfun) 
library(xml2)
library(jsonlite)
#library(magrittr)
library(jsonlite)
library(XML)
# library(httr)
# library(rvest)
# library(dplyr)
# library(V8)


url <- "https://datacovid.salud.aragon.es/covid/"


mybrowser <- rsDriver(browser = "firefox")

remDr <- mybrowser[["client"]]

remDr$navigate(url)

Sys.sleep(9)

#2.2 ZARAGOZA----





categorykey_prov <-remDr$findElement('xpath', '/html/body/div[1]/div/div/div[1]/div[1]/div[3]/div[1]/div/div/div/div[1]')

categorykey_prov$clickElement()

Sys.sleep(2)

categorykey_zaragoza <-remDr$findElement('xpath', '/html/body/div[1]/div/div/div[1]/div[1]/div[3]/div[1]/div/div/div/div[2]/div/div[1]')

categorykey_zaragoza$clickElement()

Sys.sleep(9)

parsed_pagesource_zaragoza<- remDr$getPageSource()[[1]]



total_cases_zaragoza <- xml2::read_html(parsed_pagesource_zaragoza) %>%
  rvest::html_nodes(css = "#total") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)


total_muertes_zaragoza <- xml2::read_html(parsed_pagesource_zaragoza) %>%
  rvest::html_nodes(css = "#muertes") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)



total_recuperados_zaragoza <- xml2::read_html(parsed_pagesource_zaragoza) %>%
  rvest::html_nodes(css = "#recuperados") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)


#2.2 HUESCA----


#categorykey_prov <-remDr$findElement('xpath', '/html/body/div[1]/div/div/div[1]/div[1]/div[3]/div[1]/div/div/div/div[1]')

categorykey_prov$clickElement()

Sys.sleep(2)

categorykey_huesca <-remDr$findElement('xpath', '/html/body/div[1]/div/div/div[1]/div[1]/div[3]/div[1]/div/div/div/div[2]/div/div[2]')

categorykey_huesca$clickElement()
Sys.sleep(9)
parsed_pagesource_huesca<- remDr$getPageSource()[[1]]



total_cases_huesca <- xml2::read_html(parsed_pagesource_huesca) %>%
  rvest::html_nodes(css = "#total") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)


total_muertes_huesca <- xml2::read_html(parsed_pagesource_huesca) %>%
  rvest::html_nodes(css = "#muertes") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)



total_recuperados_huesca <- xml2::read_html(parsed_pagesource_huesca) %>%
  rvest::html_nodes(css = "#recuperados") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)




#2.3 TERUEL----


#categorykey_prov <-remDr$findElement('xpath', '/html/body/div[1]/div/div/div[1]/div[1]/div[3]/div[1]/div/div/div/div[1]')

categorykey_prov$clickElement()

Sys.sleep(2)

categorykey_teruel <-remDr$findElement('xpath', '/html/body/div[1]/div/div/div[1]/div[1]/div[3]/div[1]/div/div/div/div[2]/div/div[3]')

categorykey_teruel$clickElement()
Sys.sleep(9)
parsed_pagesource_teruel<- remDr$getPageSource()[[1]]



total_cases_teruel <- xml2::read_html(parsed_pagesource_teruel) %>%
  rvest::html_nodes(css = "#total") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)


total_muertes_teruel <- xml2::read_html(parsed_pagesource_teruel) %>%
  rvest::html_nodes(css = "#muertes") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)



total_recuperados_teruel <- xml2::read_html(parsed_pagesource_teruel) %>%
  rvest::html_nodes(css = "#recuperados") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)





fechass <- xml2::read_html(parsed_pagesource_teruel) %>%
  rvest::html_nodes(xpath = "/html/body/div[1]/div/div/div[1]/div[1]/div[4]/div[2]/div/div/input[2]")

fechas <- xml_attr(fechass, "data-initial-date")


#CASOS TAB----



Sys.sleep(9)

casos_tab <-remDr$findElement('xpath', '/html/body/div[1]/div/ul/li[10]/a')

casos_tab$clickElement()


Sys.sleep(9)

fecha_casos_tab <-remDr$findElement('xpath', '/html/body/div[1]/div/div/div[10]/div[1]/div[4]/div/div/input[1]')

fecha_casos_tab$clickElement()

Sys.sleep(3)

monthback_casos_tab <-remDr$findElement('xpath', '/html/body/div[4]/div[1]/table/thead/tr[2]/th[1]')

monthback_casos_tab$clickElement()
monthback_casos_tab$clickElement()
monthback_casos_tab$clickElement()
monthback_casos_tab$clickElement()
monthback_casos_tab$clickElement()
monthback_casos_tab$clickElement()
monthback_casos_tab$clickElement()
monthback_casos_tab$clickElement()
monthback_casos_tab$clickElement()
monthback_casos_tab$clickElement()
monthback_casos_tab$clickElement()

diauno <- remDr$findElement('xpath', '/html/body/div[4]/div[1]/table/tbody/tr[1]/td[3]')


diauno$clickElement()


Sys.sleep(2)

categorykey_provincel <-remDr$findElement('xpath', '/html/body/div[1]/div/div/div[10]/div[1]/div[2]/div/div/div/div[1]')

categorykey_provincel$clickElement()

Sys.sleep(9)


#ZARAGOZA casostab----
categorykey_casostab_zaragoza <-remDr$findElement('xpath', '/html/body/div[1]/div/div/div[10]/div[1]/div[2]/div/div/div/div[2]/div/div[1]')

categorykey_casostab_zaragoza$clickElement()

Sys.sleep(9)
parsed_casostab_zaragoza<- remDr$getPageSource()[[1]]



hospi_casostab_zaragoza <- xml2::read_html(parsed_casostab_zaragoza) %>%
  rvest::html_nodes(css = "#ingresos2") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)


uci_casostab_zaragoza <- xml2::read_html(parsed_casostab_zaragoza) %>%
  rvest::html_nodes(css = "#UCI2") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)




#HUESCA casostab----

categorykey_provincel$clickElement()

Sys.sleep(2)

categorykey_casostab_huesca <-remDr$findElement('xpath', '/html/body/div[1]/div/div/div[10]/div[1]/div[2]/div/div/div/div[2]/div/div[2]')

categorykey_casostab_huesca$clickElement()

Sys.sleep(9)

parsed_casostab_huesca<- remDr$getPageSource()[[1]]



hospi_casostab_huesca <- xml2::read_html(parsed_casostab_huesca) %>%
  rvest::html_nodes(css = "#ingresos2") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)


uci_casostab_huesca <- xml2::read_html(parsed_casostab_huesca) %>%
  rvest::html_nodes(css = "#UCI2") %>% 
  html_text() %>% 
  gsub("\n", "", .)  %>% 
  gsub("\\.","",.)





#TERUEL casostab----

categorykey_provincel$clickElement()

Sys.sleep(2)

categorykey_casostab_teruel <-remDr$findElement('xpath', '/html/body/div[1]/div/div/div[10]/div[1]/div[2]/div/div/div/div[2]/div/div[3]')

categorykey_casostab_teruel$clickElement()

Sys.sleep(9)

parsed_casostab_teruel<- remDr$getPageSource()[[1]]



hospi_casostab_teruel <- xml2::read_html(parsed_casostab_teruel) %>%
  rvest::html_nodes(css = "#ingresos2") %>% 
  html_text() %>% 
  gsub("\n", "", .) %>% 
  gsub("\\.","",.)


uci_casostab_teruel <- xml2::read_html(parsed_casostab_teruel) %>%
  rvest::html_nodes(css = "#UCI2") %>% 
  html_text() %>% 
  gsub("\n", "", .)  %>% 
  gsub("\\.","",.)









remDr$close()

mybrowser$server$stop()

remDr$close()
rm(mybrowser)
gc()



#Build dataframe----

datos_aragon_dia <- tibble(province = c("Zaragoza", "Huesca", "Teruel"),
             date = c(fechas, fechas, fechas),
             cases_accumulated = c(total_cases_zaragoza, total_cases_huesca, total_cases_teruel),
             deceased = c(total_muertes_zaragoza, total_muertes_huesca, total_muertes_teruel),
             hospitalized = c(hospi_casostab_zaragoza, hospi_casostab_huesca, hospi_casostab_teruel),
             intensive_care = c(uci_casostab_zaragoza, uci_casostab_huesca, uci_casostab_teruel)) %>% 
  mutate_at(vars(3:6), list(as.numeric)) %>% 
  mutate(date = as.Date(date))

fecha_for_filter <- datos_aragon %>% 
  select(date) %>% 
  unique() %>% 
  pull()

aragon_old <- read_csv("https://raw.githubusercontent.com/montera34/escovid19data/master/data/original/aragon/actualizacion_datos_aragon.csv") %>% 
  filter(date != fecha_for_filter)

datos_aragon <- aragon_old %>% 
  rbind(datos_aragon_dia)


write_csv(datos_aragon, "actualizacion_datos_aragon.csv")


