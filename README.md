# Escovid19data: Capturando colaborativamente datos de COVID-19 por provincias en España

[![GitHub license](https://img.shields.io/badge/License-Creative%20Commons%20Attribution%204.0%20International-blue)](https://github.com/montera34/escovid19data/blob/master/LICENSE.md)
[![GitHub commit](https://img.shields.io/github/last-commit/pcm-dpc/COVID-19)](https://github.com/montera34/escovid19data/commits/master)

## ¿Puedes utilizar los datos? ¿Cómo colaborar?

[Pon link a este repositorio (https://github.com/montera34/escovid19data)](https://github.com/montera34/escovid19data) y llámalo Escovid19data. Liberamos los datos para que hagas con ellos lo que quieras. Si nos citas, mejor, para mantener la trazabilidad de los datos. Nos encantará saber que usas los datos, escríbemos a covid19@montera34.com o tuitea con #escovid19data.
Ver condiciones de [la licencia con que compartimos los datos](https://github.com/montera34/escovid19data/blob/master/LICENSE.md).

Puedes ayudar colaborando actiamente en la recopilación de daos o detectando errores y notificándolos. Puedes ponernos un email, o mejor, [crear un incidencia](https://github.com/montera34/escovid19data/issues). 

## Los datos / The data

Los datos por provincias se publican en este CSV: [/data/output/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/blob/master/data/output/covid19-provincias-spain_consolidated.csv).

Se han creado datos agregados por CCAA y para toda España en el directorio [```/data/output/```](https://github.com/montera34/escovid19data/tree/master/data/output):

* **covid19-ccaa-spain_consolidated.(rds, csv, xlsx)** para datos agregados por comunidades autónomas
* **covid19-spain_consolidated.(rds, csv, xlsx)** para datos agregados para toda España

Incluye el código del INE para las provincias y datos relativos a 100.000 habitantes.
Cuando se indica 'NA' es que no hay datos disponibles.

Los datos se descargan de múltiples fuentes. Tanto los descargados automáticamente de repositorios de datos abiertos como los que se recopilan manualmente en una hoja de cálculo online compatida son luego procesados con este [script de R](https://code.montera34.com:4443/numeroteca/covid19/-/blob/master/analysis/process_spain_provinces_data.R) en otro repositorio. 

Los datos originales usados son almacenados en este directorio: [/data/original/spain](https://code.montera34.com/numeroteca/covid19/-/tree/master/data/original/spain). Puedes acceder a datos más desagregados que ls provinicas, por ejemplo a datos por [islas de Canarias](https://code.montera34.com/numeroteca/covid19/-/tree/master/data/original/spain/canarias) o por [área sanitaria en Galicia](https://code.montera34.com/numeroteca/covid19/-/tree/master/data/original/spain/galicia). Hay una carpeta por cada comunidad o ciudad autónoma. En los estados de git puedes acceder a cómo estaban los datos en cada momento.

**EN**

Data are published in this CSV file: [/data/output/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/blob/master/data/output/covid19-provincias-spain_consolidated.csv)

It includes now INE code for provinces and data per 100.000 inhabitants.
'NA' is indicated when no data is available.

### Variables

Datos originales | Original data:

* `date` Día en formato aaaa-mm-dd | Day in yyyy-mm-dd format
* `province` Provincia | Province
* `ine_code` Código de provinci del INE | INE code fro the province
* `ccaa` Comunidad autónoma | Region 
* `new_cases` Número de nuevos casos COVID-19 detectados | Number of new COVID-19 cases 
* `PCR` Número de nuevos casos detectados COVID-19 por PCR | Number of new COVID-19 cases detected with PCR
* `TestAc` Número de nuevos casos detectados COVID-19 por test de anticuerpos | Number of new COVID-19 cases detected with Ac
* `activos` Casos de COVID-19 activos | Active COVID-19 cases
* `hospitalized` Hospitalizados (acumulativvo y no acumulativo) | Hospitalized.  [Ver | View wiki](https://github.com/montera34/escovid19data/wiki#hospitalizados)
* `intensive_care` Pacientes en UCI | UCI (intensive care patiens)
* `deceased` Deaths (cumulative)
* `cases_accumulated` Casos COVID-19 detectados acumulado | Number of new COVID-19 cases (cumulative)
* `cases_accumulated_PCR` Casos COVID-19 detectados por PCR acumulado | Number of new COVID-19 cases detected with PCR (cumulative)
* `recovered` Recuperados | Recovered
* `poblacion` Población de la provincia | Inhabitants of the province

Datos de RENAVE-ISCIII: la fecha de inicio de síntomas o, en su defecto, la fecha de diagnóstico menos 6 días (con prefijo `num_`) (fuente: https://cnecovid.isciii.es/covid19/resources/datos_provincias.csv),

* `num_casos` el número de casos totales, confirmados o probables
* `num_casos_prueba_pcr` el número de casos con prueba de laboratorio PCR o técnicas moleculares
* `num_casos_prueba_test_ac` el número de casos con prueba de laboratorio de test rápido de anticuerpos
* `num_casos_prueba_otras` el número de casos con otras pruebas de laboratorio, mayoritariamente por detección de antígeno o técnica Elisa
* `num_casos_prueba_desconocida` el número de casos sin información sobre la prueba de laboratorio

Datos calculados a partir de los datos de arriba | Calculated data:

* `cases_per_cienmil` Casos acumulados por 100.000 habitantes | Cumulative cases per 100,000 inhabitants
* `intensive_care_per_100000` Casos UCI por 100.000 habitantes | Intensive care per 100,000 inhabitants
* `hospitalized_per_100000` Hospitalizados por 100.000 habitantes | Intensive care per 100,000 inhabitants [Ver | View wiki](https://github.com/montera34/escovid19data/wiki#hospitalizados)
* `deceassed_per_100000` Fallecidos acumulados por 1000.000 habitantes | Cumulative deaths per 100,000 inhabitants
* `cases_14days` Casos detectados en los últimos 14 días | Detected cases in the last 14 days
* `daily_cases` Casos diarios. Calculado como la diferencia de los casos acumulados | Daily cases. Calculated as a difference of cumulative cases reported.
* `daily_cases_avg7` Media de casos detectados (ventana de 7 días) | Average daily cases in the last 7 days (rolling average 7 days)
* `daily_cases_PCR_avg7` Media de casos PCR detectados (ventana de 7 días) | Average daily cases PCR in the last 7 days (rolling average 7 days) 
* `daily_deaths` Fallecidos diarios | Daily deaths. Calculated as a difference of cumulative deaths reported.
* `daily_deaths_inc` Porcentaje de nuevos falllecidos respecto de día anterior | Calculated as the percentage from last day
* `daily_deaths_avg3` Media de fallecidos en los últimos 3 días | Average daily deaths in the last 3 days (rolling average 3 days) 
* `daily_deaths_avg6` Media de fallecidos en los últimos 7 días | Average daily deaths in the last 7 days (rolling average 7 days) 
* `deaths_last_week` Fallecidos en los últimos 7 días | Deaths in the last 7 days.

* `num_casos_prueba_pcr_avg7` Media de casos (ventana de 7 días) de casos con prueba de laboratorio PCR o técnicas moleculares de los datos de RENAVE-ISCIII 

Fuente de los datos y comentarios | Data sources and comments:

* `source_name` Nombre de la fuente separados por ; | Name of source of information, separated by ;
* `source` URL de la fuente separado por ; | Source URL of information, separated by ;
* `comments` COmentario sobre los datos | Comments of the data

### Población por provincias (2019)

Población por provincias del INE:  https://www.ine.es/jaxiT3/Datos.htm?t=2852#!tabs-tabla

## Sobre la iniciativa

Este es un proyecto colaborativo para mejorar los datos sobre COVID-19 en España por provincias.

* [Hoja de cálculo de trabajo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=0) en la que anotamos manualmente algunas de las sereis de datos. Ayúdanos a completarla. Pide acceso. Si detectas errores háznoslo saber.
* Llamamiento inicial para colaborar iniciales para conseguir los datos de [@numeroteca](https://twitter.com/numeroteca/status/1239853592569425920) y [@ProsumidorSoc](https://twitter.com/ProsumidorSoc/status/1240569799056461826).

Contacto: covid19@montera34.com

### ¿Quíen está detrás de esto?

Hay muchas personas que nos habéis ayudado y aportado pistas. Gracias a todas por colaborar. 

Ahora mismo, estamos manteniendo los datos y amadrinando provincias y comunidades autónomas: [@ProsumidorSoc](https://twitter.com/ProsumidorSoc) [@numeroteca](https://twitter.com/numeroteca) [@arivero](https://twitter.com/arivero) [@ManoloYuri](https://twitter.com/ManoloYuri) [@congosto](https://twitter.com/congosto) [@skotperez](https://twitter.com/skotperez) [@allisdata](https://twitter.com/@allisdata) [@acorsin](https://twitter.com/acorsin) [@hhkaos](https://twitter.com/hhkaos) [@belengarcia_8](https://twitter.com/belengarcia_8) [@Tejerauskas](https://twitter.com/Tejerauskas) [@aniol](https://twitter.com/aniol) [@zgzmiki89](https://twitter.com/zgzmiki89) [@mota_santiago](https://twitter.com/mota_santiago) [@nachotronic](https://twitter.com/nachotronic) [@puzzle72](https://twitter.com/@puzzle72) [@montera34](https://twitter.com/@montera34) [@alfonsotwr](https://twitter.com/alfonsotwr) [@lipido](https://twitter.com/lipido) [@danielegrasso](https://twitter.com/danielegrasso) [@picanumeros](https://twitter.com/picanumeros) [@walyt](https://twitter.com/walyt).

Coordina el proyecto [@numeroteca](https://twitter.com/numeroteca)

Si se nos olvida alguien ¡avísanos!

Cada cual se encarga de amadrinar una comunidad autónoma. [Ver sección "Organización" de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=179891808).
 
## Visualizaciones y uso de los datos

Mándanos tu análisis o visualización si usas estos datos (covid19@montera34.com):

Actualizado diariamente: 
* [Gráficos por provincias](https://lab.montera34.com/covid19/provincias.html) mantenido por [@numeroteca](https://twitter.com/numeroteca) en [@montera34](https://twitter.com/montera34)). 
* [Tablas por provincias y CCAA](https://lab.montera34.com/covid19-r/reports/tablas-escovid19data.html) mantenido por [@numeroteca](https://twitter.com/numeroteca. Se generan automáticamente con RMarkdown.
* [Visualización de evolución de múltiples variables](https://iguacel.github.io/iguacel/#/exp/20) mantenido por [@infoiguacel](https://twitter.com/infoiguacel).
* [Un dashboard de análisis](https://cultureofinsight.shinyapps.io/covid-19/) mantenido por [@harlesden88](https://twitter.com/harlesden88).

No se actualizan:
* [Dashboard interactivo en Tableau con los datos provinciales (en Tableau Public)](https://public.tableau.com/profile/javier.cant.n#!/vizhome/COVIDprov/Historia1?publish=yes) mantenido por [@ProsumidorSoc](https://twitter.com/ProsumidorSoc).
* [La evolución del COVID-19 en España y en el mundo, en gráficos](https://picanumeros.wordpress.com/2020/03/13/la-evolucion-del-covid-19-en-espana-en-graficos/) por [@picanumeros](https://twitter.com/picanumeros)
* [Mapas de afectados por coronavirus en España](https://mapa-de-afectados-por-coronavirus-plataformacovid.hub.arcgis.com/) iniciativa mantenida por voluntarios e impulsada por Esri España.



### Prensa

* eldiario: ¿Por qué Canarias resiste al coronavirus y Soria no?  (Raquel Ejerique, Raúl Sánchez) https://www.eldiario.es/sociedad/Canarias-pocos-casos-coronavirus-Segovia_0_1017698330.html
* ABC: Las provincias que mejor y peor llegan para pasar a la siguiente fase de la desescalada (Luís Cano) https://www.abc.es/sociedad/abci-coronavirus-provincias-mejor-y-peor-llegan-para-pasar-siguiente-fase-desescalada-202005051948_noticia.html
* El País: Residencias, UCI y aglomeración: los puntos débiles de cada provincia para enfrentar al virus en la nueva fase (Borja Andrino, Daniele Grasso, Kiko Llaneras)  https://elpais.com/sociedad/2020-05-10/residencias-uci-y-aglomeracion-los-puntos-debiles-de-cada-provincia-para-enfrentar-al-virus-en-la-nueva-fase.html
* El País: Lo que inquieta del estudio de prevalencia en España: ¿Un muerto por cada 100 infectados? (Borja Andrino, Daniele Grasso, Kiko Llaneras) https://elpais.com/sociedad/2020-05-13/lo-que-inquieta-del-estudio-de-prevalencia-en-espana-un-muerto-por-cada-100-infectados.html 
* El País: El mapa del riesgo de rebrote en España: consulta la situación de tu provincia (Borja Andrino, Daniele Grasso, Kiko Llaneras, Luís Sevillano, Ignacio Povedano, Fernando Hernández) https://elpais.com/especiales/2020/coronavirus-covid-19/fases-desescalada/riesgo-de-rebrotes/
* El País: Asteriscos, incoherencias y opacidad: 15 problemas de Sanidad con la gestión de datos del coronavirus  (Borja Andrino, Daniele Grasso, Kiko Llaneras) https://elpais.com/sociedad/2020-05-26/asteriscos-incoherencias-y-opacidad-15-problemas-del-ministerio-con-la-gestion-de-datos-del-coronavirus.html
* El País: EsCovid19data: los voluntarios que llevan tres meses poniendo orden en los datos de la pandemia (Montse Hidalgo Pérez) https://elpais.com/tecnologia/2020-06-08/escovid19data-los-voluntarios-que-llevan-tres-meses-poniendo-orden-en-los-datos-de-la-pandemia.html
* ¿Qué dicen los datos de agosto sobre la nueva expansión del coronavirus en España? (Kiko Llaneras, Artur Galocha) https://elpais.com/sociedad/2020-08-22/que-dicen-los-datos-de-agosto-sobre-la-nueva-expansion-del-coronavirus-en-espana.html 

### Artículos científicos

* Briz-Redón, Á., & Serrano-Aroca, Á. (2020). A spatio-temporal analysis for exploring the effect of temperature on COVID-19 early evolution in Spain. Science of The Total Environment, 138811. https://www.sciencedirect.com/science/article/pii/S0048969720323287
* "Effects of mobility and multi-seeding on the propagation of the COVID-19 in Spain" (pre-print) Mattia Mazzoli, David Mateo, Alberto Hernando, Sandro Meloni y Jose Javier Ramasco. https://www.medrxiv.org/content/10.1101/2020.05.09.20096339v2
* "Regional correlations of COVID-19 in Spain" (pre-print) por Daniel Oto-Peralías https://osf.io/tjdgw/download
* Paez, A., Lopez, F. A., Menezes, T., Cavalcanti, R., & Pitta, M. G. D. R. A Spatio‐Temporal Analysis of the Environmental Correlates of COVID‐19 Incidence in Spain. Geographical Analysis. https://onlinelibrary.wiley.com/doi/full/10.1111/gean.12241. Los datos finalmente usados, recopilando diferentes bases de datos [pueden verse en este repositorio](https://github.com/paezha/covid19-environmental-correlates).
* Martorell-Marugán, J., Villatoro-García, J. A., García-Moreno, A., López-Domínguez, R., Requena, F., Merelo, J. J., ... & Carmona-Sáez, P. (2020). DatAC: A visual analytics platform to explore climate and air quality indicators associated with the COVID-19 pandemic in Spain. Science of The Total Environment, 141424. https://doi.org/10.1016/j.scitotenv.2020.141424 Se usan los datos de Escovid19data en la herramienta DatAC (https://covid19.genyo.es). En esta herramienta de visualización y análisis integramos los datos de COVID-19 con datos de factores ambientales como contaminantes y variables meteorológicas. El artículo describiendo la herramienta ha sido recientemente publicado en la revista Science of the Total Environment y puede consultarse aquí: https://doi.org/10.1016/j.scitotenv.2020.141424

## Fuentes de información y estado de la base de datos

Puedes ver el análisis sobre las fuentes de información y el estado de la base de datos [en este informe automatizado](https://lab.montera34.com/covid19-r/reports/informe-escovid19data.html).

Se han usado varias fuentes, la mayoría oficiales, algunas periodísicas, que se indican en cada una de los datos por día y provincia en la columna "source".
Puedes leer más información sobre cada [una de las fuentes en este documento](https://docs.google.com/document/d/12wkE0w1kdBHdwkj6AhPc0VnSQHgP_zz5rcVTyqng5y8/edit#).

También puedes encontrar (y contribuir) información más actualizada en [la wiki  de este repositorio](https://github.com/montera34/escovid19data/wiki).

En la wiki  puedes encontrar información sobre las fuentes e historia de la recopilació nde datos de cada comunidad autónoma.

## Cómo funciona el proceso de obtención y publicación de los datos

Cada madrina, reponsable de conseguir los datos, de una comunidad autónoma o provincia sube los datos a una hoja de cálculo común o busca fuentes que podamos descargar y procesar automáticamente.

Los datos de esa hoja de cálculo se descargaban en este CSV: `data/original/covid19_spain_provincias.csv` para ser procesadod con el [script de R](https://code.montera34.com:4443/numeroteca/covid19/-/blob/master/analysis/process_spain_provinces_data.R), pero ahora el script hace mucho más que eso. Descaga los datos de cada una de las pestañas y fuentes originales, procesa y une los datos y genera el CSV listo para usarse [/data/output/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/-/blob/master/data/output/covid19-provincias-spain_consolidated.csv). También puedes descargar los datos en formato .xlsx y .rds.

No todos los datos están disponibles en la hoja de cálculo compartida, como se indica en algunas comunidades se obtiene directamente de la fuente.

El proyecto tiene un grupo de Telegram con el que nos coordinamos. Escribe a covid19@montera34.com para apuntarte, colaborar y saber más.
