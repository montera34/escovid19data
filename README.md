# Escovid19data: Capturando datos por provincias en España

**IMPORTANTE** 
Faltan datos de fallecimientos enBarcelona. Se calculan en base a las otras 3 provincias catalanas.
Los datos de Girona para casos acumulados experimentan un descenso debido al cambio de criterio en la contabilidad (día 28.03.2020).

## ¿Puedes utilizar los datos? 

[Pon link a este repositorio](https://github.com/montera34/escovid19data) y de nombre Escovid19data. Los liberamos para que hagas con ellos lo que quieras. Si nos citas, mejor, para mantener la trazabilidad de los datos. 

## Los datos / The data

Los datos se publican en este CSV: [/data/output/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/blob/master/data/output/covid19-provincias-spain_consolidated.csv)

Data are published in this CSV file: [/data/output/spain/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/blob/master/data/output/covid19-provincias-spain_consolidated.csv)

It includes now INE code for provinces and data per 100.000 inhabitants.
'NA' is indicated when no data is available.

Downloaded data from working spreadsheet are processed with analysis/evolution_spain_province.R script.

* `date` Day
* `province` Province
* `ine_code` INE code fro the province
* `ccaa` Comunidad autónoma (region)
* `new_cases` Number of new COVID-19 cases
* `activos` Active COVID-19 cases
* `hospitalized` Hospitalized (cumulative)
* `intensive_care` UCI (intensive care patiens) (cumulative)
* `deceased` Deaths (cumulative)
* `cases_accumulated` Cases (cumulative)
* `recovered` Recovered (cumulative)
* `poblacion` Inhabitants of the province
* `cases_per_cienmil` Cumulative cases per 100,000 inhabitants
* `intensive_care_per_1000000` Cumulative cases per 100,000 inhabitants
* `deceassed_per_100000` Cumulative deaths per 100,000 inhabitants
* `daily_deaths` Daily deaths. Calculated as a difference of cumulative deaths
* `daily_deaths_inc` Calculated as the percentage from last day (cumulativ)
* `daily_deaths_avg3` Average daily deaths in the last 3 days (current and last 2 days) 
* `daily_deaths_avg6` Average daily deaths in the last 6 days (current and last 5 days) 
* `source` Source of information, separated by ;
* `comments` Comments of the data

Structure of CSV:

| "date"       | "province"          | "ine\_code" | "ccaa"                 | "new\_cases" | "activos" | "hospitalized" | "intensive\_care" | "deceased" | "cases\_accumulated" | "recovered" | "poblacion" | "cases\_per\_cienmil" | "intensive\_care\_per\_1000000" | "deceassed\_per\_100000" | "daily\_deaths" | "daily\_deaths\_inc" | "daily\_deaths\_avg3" | "daily\_deaths\_avg6" | "source"                                                            | "comments" |
|--------------|---------------------|-------------|------------------------|--------------|-----------|----------------|-------------------|------------|----------------------|-------------|-------------|-----------------------|---------------------------------|--------------------------|-----------------|----------------------|-----------------------|-----------------------|---------------------------------------------------------------------|------------|
| 2020\-03\-27 | "Badajoz"           | 6           | "Extremadura"          | 61           | 352       | 91             | 18                | 10         | 390                  | 27          | 673559      | 57\.9                 | 2\.67                           | 1\.48                    | 2               | 25                   | 2\.3                  | 1\.5                  | "http://www\.juntaex\.es/comunicac\.\.\."                           | ""         |
| 2020\-03\-27 | "Burgos"            | 9           | "Castilla y León"      | 74           | NA        | 243            | 49                | 39         | 604                  | 95          | 356958      | 169\.21               | 13\.73                          | 10\.93                   | 7               | 21\.9                | 5                     | 4\.2                  | "https://analisis\.datosabiertos\.jcyl\.es/pag\.\.\."               | ""         |
| 2020\-03\-27 | "Valencia/València" | 46          | "Comunitat Valenciana" | 239          | NA        | 840            | 140               | 88         | 2027                 | NA          | 2565124     | 79\.02                | 5\.46                           | 3\.43                    | 16              | 22\.2                | 14                    | 12\.2                 | "http://www\.san\.gva\.es/comunica\.\.\.pdf\)"                      | ""         |
| 2020\-03\-28 | "Almería"           | 4           | "Andalucía"            | NA           | 173       | 72             | NA                | 10         | 173                  | NA          | 716820      | 24\.13                | NA                              | 1\.4                     | 2               | 25                   | 1\.7                  | 1\.5                  | "https://www\.juntadeandalucia\.es/organismos/salu\.\.\.3791\.html" | ""         |

                                                                                               | 
### Población por provincias (2019)

Población por provincias del INE:  https://www.ine.es/jaxiT3/Datos.htm?t=2852#!tabs-tabla


## Sobre la iniciativa

Este es un proyecto colaborativo para mejorar los datos sobre COVID-19 en España.

* [Hoja de cálculo de trabajo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=0). Ayúdanos a completarla. Pide acceso. Si detectas errores háznoslo saber.
* Llamamiento para colaborar iniciales para conseguir los datos de [@numeroteca](https://twitter.com/numeroteca/status/1239853592569425920) y [@ProsumidorSoc](https://twitter.com/ProsumidorSoc/status/1240569799056461826).

Contacto: covid19@montera34.com

### ¿Quíen está detrás de esto?

Hay muchas personas que nos habéis ayudado y aportado pistas. Gracias a todas por colaborar. 

Ahora mismo, estamos manteniendo los datos y amadrinando provincias y comunidades autónomas: [@ProsumidorSoc](https://twitter.com/ProsumidorSoc) [@numeroteca](https://twitter.com/numeroteca) [@arivero](https://twitter.com/arivero) [@ManoloYuri](https://twitter.com/ManoloYuri) [@congosto](https://twitter.com/congosto) [@skotperez](https://twitter.com/skotperez) [@leu2001](https://twitter.com/leu2001) [@allisdata](https://twitter.com/@allisdata) [@arivero](https://twitter.com/arivero) [@acorsin](https://twitter.com/acorsin) [@hhkaos](https://twitter.com/hhkaos) [@aitorcalero](https://twitter.com/aitorcalero) [@belengarcia_8](https://twitter.com/belengarcia_8) [@Tejerauskas](https://twitter.com/Tejerauskas) [@aniol](https://twitter.com/aniol) | [@zgzmiki89](https://twitter.com/zgzmiki89) | [@jf_caro](https://twitter.com/jf_caro) [@mota_santiago](https://twitter.com/mota_santiago).

Si se nos olvida alguien ¡avísanos!

Cada cual se encarga de una comunidad autńoma o provincia. [Ver sección "Organización" de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=179891808).
 
## Visualizaciones 

Mándanos tu análisis o visualización si usas estos datos (covid19@montera34.com):

* [Gráficos y códido de R disponibles](https://lab.montera34.com/covid19/#fallecimientosDiaProvincias) mantenido por [@montera34](https://twitter.com/montera34)).
* [Dashboard interactivo en Tableau con los datos provinciales (en Tableau Public)](https://public.tableau.com/profile/javier.cant.n#!/vizhome/COVIDprov/Historia1?publish=yes) mantenido por [@ProsumidorSoc](https://twitter.com/ProsumidorSoc).
* [Mapas de afectados por coronavirus en España](https://mapa-de-afectados-por-coronavirus-plataformacovid.hub.arcgis.com/) iniciativa mantenida por voluntarios e impulsada por Esri España.
* [Un dashboard de análisis](https://cultureofinsight.shinyapps.io/covid-19/) mantenido por [@harlesden88](https://twitter.com/harlesden88)

## Fuentes

Se han usado varias fuentes, la mayoría oficiales, algunas periodísicas, que se indican en cada una de los datos por día y provincia en la columna "source".
Puedes leer más información sobre cada una de las fuentes: https://docs.google.com/document/d/12wkE0w1kdBHdwkj6AhPc0VnSQHgP_zz5rcVTyqng5y8/edit#

## Cómo funciona

Cada amdrina de una comunidad autónoma o provincia sube los datos a una hoja de cálculo común.
Los datos se descargan en este CSV: 'data/original/covid19_spain_provincias.cs'v para ser procesador con el script de R 'analysis/procesar_por_provincia.R' y se genera el CSV listo para usarse [/data/output/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/-/blob/master/data/output//covid19-provincias-spain_consolidated.csv).





