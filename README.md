# Escovid19data: Capturando datos de COVID-19 por provincias en España

[![GitHub license](https://img.shields.io/badge/License-Creative%20Commons%20Attribution%204.0%20International-blue)](https://github.com/montera34/escovid19data/blob/master/LICENSE.md)
[![GitHub commit](https://img.shields.io/github/last-commit/pcm-dpc/COVID-19)](https://github.com/montera34/escovid19data/commits/master)

## ¿Puedes utilizar los datos? ¿Cómo colaborar?

[Pon link a este repositorio (https://github.com/montera34/escovid19data)](https://github.com/montera34/escovid19data) y llámalo Escovid19data. Liberamos los datos para que hagas con ellos lo que quieras. Si nos citas, mejor, para mantener la trazabilidad de los datos. Nos encantará saber que usas los datos, escríbemos a covid19@montera34.com o tuitea con #escovid19data.
Ver condiciones de [la licencia con que compartimos los datos](https://github.com/montera34/escovid19data/blob/master/LICENSE.md).

Puedes ayudar colaborando actiamente en la recopilación de daos o detectando errores y notificándolos. Puedes ponernos un email, o mejor, [crear un incidencia](https://github.com/montera34/escovid19data/issues). 

## Los datos / The data

**ES**

Los datos se publican en este CSV: [/data/output/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/blob/master/data/output/covid19-provincias-spain_consolidated.csv)

Incluye el código del INE pra las provincias y datos relativos a 100.000 habitantes.
Cuando se indica 'NA' es que no hay datos disponibles.

Los datos descarados de las hoja de cálculo son procesados con este [script de R](https://code.montera34.com:4443/numeroteca/covid19/-/blob/master/analysis/process_spain_provinces_data.R) en otro repositorio. 

Los datos originales usados son almacenados en este directorio: [/data/original/spain](https://code.montera34.com/numeroteca/covid19/-/tree/master/data/original/spain). Puedes acceder a datos más desagregados que ls provinicas, por ejemplo a datos por [islas de Canarias](https://code.montera34.com/numeroteca/covid19/-/tree/master/data/original/spain/canarias) o por [área sanitaria en Galicia](https://code.montera34.com/numeroteca/covid19/-/tree/master/data/original/spain/galicia).

**EN**

Data are published in this CSV file: [/data/output/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/blob/master/data/output/covid19-provincias-spain_consolidated.csv)

It includes now INE code for provinces and data per 100.000 inhabitants.
'NA' is indicated when no data is available.

Downloaded data from the working spreadsheet are processed with this [R script](https://code.montera34.com:4443/numeroteca/covid19/-/blob/master/analysis/process_spain_provinces_data.R) in another repository.

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

Datos de ISCIII: la fecha de inicio de síntomas o, en su defecto, la fecha de diagnóstico menos 6 días (con prefijo `num_`) (fuente: https://cnecovid.isciii.es/covid19/resources/datos_provincias.csv),

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

Fuente de los datos y comentarios | Data sources and comments:

* `source_name` Nombre de la fuente separados por ; | Name of source of information, separated by ;
* `source` URL de la fuente separado por ; | Source URL of information, separated by ;
* `comments` COmentario sobre los datos | Comments of the data

### Población por provincias (2019)

Población por provincias del INE:  https://www.ine.es/jaxiT3/Datos.htm?t=2852#!tabs-tabla


## Sobre la iniciativa

Este es un proyecto colaborativo para mejorar los datos sobre COVID-19 en España por provincias.

* [Hoja de cálculo de trabajo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=0). Ayúdanos a completarla. Pide acceso. Si detectas errores háznoslo saber.
* Llamamiento inicial para colaborar iniciales para conseguir los datos de [@numeroteca](https://twitter.com/numeroteca/status/1239853592569425920) y [@ProsumidorSoc](https://twitter.com/ProsumidorSoc/status/1240569799056461826).

Contacto: covid19@montera34.com

### ¿Quíen está detrás de esto?

Hay muchas personas que nos habéis ayudado y aportado pistas. Gracias a todas por colaborar. 

Ahora mismo, estamos manteniendo los datos y amadrinando provincias y comunidades autónomas: [@ProsumidorSoc](https://twitter.com/ProsumidorSoc) [@numeroteca](https://twitter.com/numeroteca) [@arivero](https://twitter.com/arivero) [@ManoloYuri](https://twitter.com/ManoloYuri) [@congosto](https://twitter.com/congosto) [@skotperez](https://twitter.com/skotperez) [@allisdata](https://twitter.com/@allisdata) [@acorsin](https://twitter.com/acorsin) [@hhkaos](https://twitter.com/hhkaos) [@belengarcia_8](https://twitter.com/belengarcia_8) [@Tejerauskas](https://twitter.com/Tejerauskas) [@aniol](https://twitter.com/aniol) [@zgzmiki89](https://twitter.com/zgzmiki89) [@mota_santiago](https://twitter.com/mota_santiago) [@nachotronic](https://twitter.com/nachotronic) [@puzzle72](https://twitter.com/@puzzle72) [@montera34](https://twitter.com/@montera34) [@alfonsotwr](https://twitter.com/alfonsotwr) [@lipido](https://twitter.com/lipido) [@danielegrasso](twitter.com/danielegrasso)

Si se nos olvida alguien ¡avísanos!

Cada cual se encarga de una comunidad autónoma o provincia. [Ver sección "Organización" de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=179891808).
 
## Visualizaciones y uso de los datos

Mándanos tu análisis o visualización si usas estos datos (covid19@montera34.com):

* [Gráficos y códido de R disponibles](https://lab.montera34.com/covid19/#fallecimientosDiaProvincias) mantenido por [@montera34](https://twitter.com/montera34)).
* [Dashboard interactivo en Tableau con los datos provinciales (en Tableau Public)](https://public.tableau.com/profile/javier.cant.n#!/vizhome/COVIDprov/Historia1?publish=yes) mantenido por [@ProsumidorSoc](https://twitter.com/ProsumidorSoc).
* [La evolución del COVID-19 en España y en el mundo, en gráficos](https://picanumeros.wordpress.com/2020/03/13/la-evolucion-del-covid-19-en-espana-en-graficos/) por [@picanumeros](https://twitter.com/picanumeros)
* [Mapas de afectados por coronavirus en España](https://mapa-de-afectados-por-coronavirus-plataformacovid.hub.arcgis.com/) iniciativa mantenida por voluntarios e impulsada por Esri España.
* [Un dashboard de análisis](https://cultureofinsight.shinyapps.io/covid-19/) mantenido por [@harlesden88](https://twitter.com/harlesden88).
* [Visualización de evolución de múltiples variables en modo cartograma](https://iguacel.github.io/iguacel/#/exp/20) mantenido por [@infoiguacel](https://twitter.com/infoiguacel).

### Prensa

* eldiario: ¿Por qué Canarias resiste al coronavirus y Soria no?  (Raquel Ejerique, Raúl Sánchez) https://www.eldiario.es/sociedad/Canarias-pocos-casos-coronavirus-Segovia_0_1017698330.html
* ABC: Las provincias que mejor y peor llegan para pasar a la siguiente fase de la desescalada (Luís Cano) https://www.abc.es/sociedad/abci-coronavirus-provincias-mejor-y-peor-llegan-para-pasar-siguiente-fase-desescalada-202005051948_noticia.html
* El País: Residencias, UCI y aglomeración: los puntos débiles de cada provincia para enfrentar al virus en la nueva fase Borja Andrino, Daniele Grasso, Kiko Llaneras)  https://elpais.com/sociedad/2020-05-10/residencias-uci-y-aglomeracion-los-puntos-debiles-de-cada-provincia-para-enfrentar-al-virus-en-la-nueva-fase.html
* El País: Lo que inquieta del estudio de prevalencia en España: ¿Un muerto por cada 100 infectados? (Borja Andrino, Daniele Grasso, Kiko Llaneras) https://elpais.com/sociedad/2020-05-13/lo-que-inquieta-del-estudio-de-prevalencia-en-espana-un-muerto-por-cada-100-infectados.html 
* El País: El mapa del riesgo de rebrote en España: consulta la situación de tu provincia (Borja Andrino, Daniele Grasso, Kiko Llaneras, Luís Sevillano, Ignacio Povedano, Fernando Hernández) https://elpais.com/especiales/2020/coronavirus-covid-19/fases-desescalada/riesgo-de-rebrotes/
* El País: Asteriscos, incoherencias y opacidad: 15 problemas de Sanidad con la gestión de datos del coronavirus  (Borja Andrino, Daniele Grasso, Kiko Llaneras) https://elpais.com/sociedad/2020-05-26/asteriscos-incoherencias-y-opacidad-15-problemas-del-ministerio-con-la-gestion-de-datos-del-coronavirus.html

### Artículos científicos

* Briz-Redón, Á., & Serrano-Aroca, Á. (2020). A spatio-temporal analysis for exploring the effect of temperature on COVID-19 early evolution in Spain. Science of The Total Environment, 138811. https://www.sciencedirect.com/science/article/pii/S0048969720323287
* "Effects of mobility and multi-seeding on the propagation of the COVID-19 in Spain" (pre-print) Mattia Mazzoli, David Mateo, Alberto Hernando, Sandro Meloni y Jose Javier Ramasco https://www.medrxiv.org/content/10.1101/2020.05.09.20096339v2
* "Regional correlations of COVID-19 in Spain" (pre-print) por Daniel Oto-Peralías https://osf.io/tjdgw/download

## Fuentes de información y estado de la base de datos

Puedes ver el análisis sobre las fuentes de información y el estado de la base de datos [en este informe automatizado](https://lab.montera34.com/covid19-r/reports/informe-escovid19data.html).

Se han usado varias fuentes, la mayoría oficiales, algunas periodísicas, que se indican en cada una de los datos por día y provincia en la columna "source".
Puedes leer más información sobre cada [una de las fuentes en este documento](https://docs.google.com/document/d/12wkE0w1kdBHdwkj6AhPc0VnSQHgP_zz5rcVTyqng5y8/edit#).

También puedes encontrar (y contribuir) información más actualizada en [la wiki  de este repositorio](https://github.com/montera34/escovid19data/wiki).

A continuación puedes encotnrar información sobre las fuentes de cada comunidad autónoma.

### Comunidades uniprovinciales: Asturias, Baleares, Cantabria, Madrid, Murcia, Navara y La Rioja (Ceuta y Melilla)

**Actualmente**:

* Desde el 21 de mayo, que el ISCIII ha dejado de publicar se usan los datos publicados por las comunidades autónomas que recopila Daniele Grasp [eneste repositorio](https://gitlab.com/elpais/datos/-/blob/master/20_Covid-19/covid-provincias/data_uniprovs.csv).
* Se tomaba la serie histórica del Instituto de Salud Carlos III (https://covid19.isciii.es/resources/serie_historica_acumulados.csv) hasta que dejóde publicarse el 20 de mayo de 2020. 
* Se usan para algunas comunidades autónomas los datos de fallecidos previos al 8 de marzo de 2020 [Datadista](https://github.com/datadista/datasets/tree/master/COVID%2019)

**Pasado**: Se usaba al principio los datos de RTVE, luego se sustituyó por los datos de los PDF del Ministerio de Sanidad que recopila Datadista.

### Andalucía

**Actualmente**: se utiliza [la serie histórica de acumulados](https://www.juntadeandalucia.es/institutodeestadisticaycartografia/badea/operaciones/consulta/anual/38228?CodOper=b3_2314&codConsulta=38228) que publica la Junta de Andalucía. La volcamos manualmente en nuestra hoja de cálculo en la pestaña "[andalucía](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=1472471361)" y descargamos directamente desde ahí.

Fuente de datos (2020.04.28): Junta de Andalucía 100%.

**Pasado**: Para los primeros días se usaron los datos que ofrecía RTVE en la [visualización hecha con Flourish](https://public.flourish.studio/visualisation/1451263/). Más tarde se usaron las notas de prensa de la Junta de Andalucía ([ver ejemplo](https://www.juntadeandalucia.es/organismos/saludyfamilias/actualidad/noticias/detalle/233232.html) del 13.03.2020).

### Aragón

**Actualmente**: Se utilizan las notas de prensa publicadas en Aragonhoy.net (Gobierno de Aragón): [ejemplo de nota de prensa de 28.04.2020](http://www.aragonhoy.net/index.php/mod.noticias/mem.detalle/area.1379/id.259392). Lo datos se vuelcan en la pestaña común ["provincias" de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=0). 

**Pasado**: Para los primeros días se usaron los datos que ofrecía RTVE en la [visualización hecha con Flourish](https://public.flourish.studio/visualisation/1451263/) y algunos periódicos.

Fuente de datos (2020.04.28): Gobierno de Aragón 66%, RTVE 21%, G. de Aragón y RTVE 8%, Prensa 5%.

### Canarias

**Actualmente**: Se utilizan las notas de prensa publicadas por el Gobierno de Canarias: [ejemplo de nota de prensa de 28.04.2020](https://www3.gobiernodecanarias.org/noticias/la-consejeria-de-sanidad-registra-1887-casos-acumulados-de-coronavirus-covid-19/). Lo datos se vuelcan en la pestaña común ["provincias" de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=0) por isla.

Fuente de datos (2020.04.28): Gobierno de Canarias 100%.

### Castilla-La Mancha

**Actualmente**: Se utilizan las notas de prensa publicadas por el Castilla-La Mancha: [ejemplo de nota de prensa de 28.04.2020](https://www.castillalamancha.es/actualidad/notasdeprensa/contin%C3%BAa-la-tendencia-de-m%C3%A1s-altas-epidemiol%C3%B3gicas-y-menos-hospitalizados-en-castilla-la-mancha-en). Lo datos se vuelcan en la pestaña común ["provincias" de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=0) por provincia.

Fuente de datos (2020.04.28): Gobierno de Castilla-La Mancha 73%, RTVE 27%.

### Castilla y León

**Actualmente**: Se descargan automáticamente tres archivos diferentes ([1](https://analisis.datosabiertos.jcyl.es/explore/dataset/situacion-epidemiologica-coronavirus-en-castilla-y-leon/download/?format=csv&timezone=Europe/Madrid&lang=en&use_labels_for_header=true&csv_separator=%3B),[2](https://analisis.datosabiertos.jcyl.es/explore/dataset/situacion-de-hospitalizados-por-coronavirus-en-castilla-y-leon/download/?format=csv&timezone=Europe/Madrid&lang=en&use_labels_for_header=true&csv_separator=%3B) y [3](https://analisis.datosabiertos.jcyl.es/explore/dataset/pruebas-realizados-coronavirus/download/?format=csv&timezone=Europe/Madrid&lang=en&use_labels_for_header=true&csv_separator=%3B)) y se integran en la base de datos.

**Pasado**: Se copia pegan datos de [la página de datos abiertos](https://analisis.datosabiertos.jcyl.es/pages/coronavirus/) de la Junta de Castilla y León en la pestaña común ["provincias" de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=0) por provincia.

Fuente de datos (2020.04.28): Junta de Castilla y León: 87%, RTVE 13%.

### Cataluña

**Actualmente**: 

* para los **casos** se usan los datos de [Transparencia de Catalunya](https://analisi.transparenciacatalunya.cat/Salut/Registre-de-test-de-COVID-19-realitzats-a-Cataluny/jj6z-iyrp/data) y se procesan con este script count_catalunya.R. Puedes ver el resultado en [este CSV](https://code.montera34.com:4443/numeroteca/covid19/-/blob/master/data/output/spain/catalunya-cases-evolution-by-province.csv). Se actualiza cada dos o tres días.

Fuente de datos (2020.05.05):  Transparencia de Catalunya 100% 

* para los **fallecidos** se ha volcado manualmente el contenido del [dashboard de Salut de la Generalitat](https://app.powerbi.com/view?r=eyJrIjoiZTkyNTcwNjgtNTQ4Yi00ZTg0LTk1OTctNzM3ZGEzNWE4OTIxIiwidCI6IjNiOTQyN2RjLWQzMGUtNDNiYy04YzA2LWZmNzI1MzY3NmZlYyIsImMiOjh9) en la [pestaña cat_ de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=841105696) que está disponible en [este CSV](https://code.montera34.com:4443/numeroteca/covid19/-/blob/master/data/original/spain/catalunya/powerbi.csv). Se actualiza cada dos o tres días.
La pega es que los datos de fallecimientos, al ser por región sanitaria no coinciden del todo con los límites geográficos de las provincia (ver siguiente tabla):

| PUEBLO /ZONA           | COMARCA REAL      | PROVÍNCIA REAL | RS ASIGNADA       | PROVINCIA RS |
|------------------------|-------------------|----------------|-------------------|--------------|
| Tora I Biosca          | Segarra           | Lleida         | Catalunya Central | Barcelona    |
| Vacarisses I Rellinars | Valles Occidental | Barcelona      | Catalunya Central | Barcelona    |
| Espinelves             | Osona             | Girona         | Catalunya Central | Barcelona    |
| Maresme Nord           | Maresme           | Barcelona      | Girona            | Girona       |
| Viladrau               | Osona             | Girona         | Catalunya Central | Barcelona    |
| Zona Baixa Segarra     | Anoia             | Barcelona      | Camp De Tarragona | Tarragona    |
| Cunit                  | Baix Penedes      | Tarragona      | Barcelona Sud     | Barcelona    |
| Gósol                  | Berguedà          | Lleida         | Catalunya Central | Barcelona    |
| Solsonés               | Solsonés          | Lleida         | Catalunya Central | Barcelona    |

Este sistema ha dejado de funcionar ya que el dashboard de Salut de la Generalitat ha dejado de diferenciar entre sospechosos y positivos y se ha pasado a recopilar de los PDF diarios.

Fuente de datos (2020.05.05):  Salut de Catalunya 100% 

* para otros datos como hospitalizados o cuidados intensivos hay una mezcla de fuentes periodísticas para Girona, Lleida y Tarragona. Falta indicar fuente para un 13%.

**Anteriormente**: los datos de casos y fallecidos para la provincia de Barcelona se calculaban en base al total de Cataluña (de Minsiterio de Sanidad- Datadista) y restando los datos de las otras tres provincias. Para Girona se usaba [este repositorio](https://github.com/nachotronic/covid19/blob/master/casos_girona.csv) mantenido por [@nachotronic](https://twitter.com/nachotronic). Para Lleida el gráfico publicado en [esta noticia de segre.com](https://www.segre.com/es/noticias/lleida/2020/03/24/lleida_suma_morts_positius_coronavirus_sol_dia_102336_1092.html). Para Tarragona múltiples fuentes periodísticas. Barcelona se calculaba restando al total de la comunidad autónoma los datos de las otras tres provincias catalanas.

### Comunidad Valenciana

**Actualmente**: Se utilizan las notas de prensa publicadas por la Generalitat Valenciana: [ejemplo de nota de prensa de 8.04.2020](https://www.gva.es/va/inicio/area_de_prensa/not_detalle_area_prensa?id=853677). Los datos se vuelcan en la pestaña común ["provincias" de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=0) por provincia.

Fuente de datos (2020.04.28): Generalitat Valenciana 87%, RTVE 13%

### Extremadura

**Actualmente**: Se utilizan las notas de prensa publicadas por la Junta de Extremdura: [ejemplo de nota de prensa de 8.04.2020](http://www.juntaex.es/comunicacion/noticia?idPub=30056#.Xo29JnJS-Cg). Los datos se vuelcan en la pestaña común ["provincias" de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=0) por provincia, previo cálculo, pues en las notas de prensa aparecen por áreas de Salud.

Fuente de datos (2020.04.28): Junta de Extremadura 81%, Prensa 10%, Falta Fuente 9%

### Galicia

**Actualmente**: El Área Sanitaria de Ourense, Verín e O Barco de Valdeorras ofrece datos de todas las áreas de Galicia, [que recopila @lipido en un repositorio] (https://github.com/lipido/galicia-covid19) desde el 2020.06.04.

**Histórico**:
* Provincia de Ourense: todos los datos históricos están recogidos en el mismo repositorio citado, https://github.com/lipido/galicia-covid19
* Provincias de A Coruña, Lugo y Pontevedra, **hasta 2020.06.03**: los datos de casos activos por área sanitaria proceden de las notas de prensa publicadas directamente por el SERGAS (en muchos casos, recopilados por Galiciancovid19). Todos los demás datos provienen de partes y comunicaciones transmitidas por cada área del SERGAS a diferentes medios. Estos medios publican los datos en forma de noticias, que han sido recopiladas y analizadas manualmente.

Fuente de datos:
* Desde 2020.06.04: Área Sanitaria de Ourense, Verín e O Barco de Valdeorras
* Hasta 2020.06.03: galiciancovid19.info (33,4%), galiciapress.es (12,0%), Área Sanitaria de Ourense, Verín e O Barco de Valdeorras (10,3%), lavozdegalicia.es (9,1%), SERGAS (7,8%), laopinioncoruna.es (4,8%), elprogreso.es (3,5%), farodevigo.es (2,9%), 20minutos.es (2,3%), vigoe.es (1,8%), diariodeferrol.com (1,3%), lavanguardia.com (1,2%), europapress.es (1,2%), cope.es (1,1%), elidealgallego.com (0,9%), diariodepontevedra.es (0,8%), metropolitano.gal (0,8%), galiciaartabradigital.com (0,7%), diariodearousa.com (0,7%), atlantico.net (0,7%), elcorreogallego.es (0,5%), laregion.es (0,4%), elespanol.com (0,4%), vigoalminuto.com (0,4%), cadenaser.com (0,2%), redaccionmedica.com (0,1%), gcdiario.com (0,1%), moncloa.com (0,1%), abc.es (0,1%), telemarinas.com (0,1%) 

### País Vasco- Euskadi

**Actualmente**: se recopila de las notas de prensa publiadas en Irekia, la página de datos abiertos del Gobierno Vasco: [ejemplo de nota de prensa de 29.04.2020](https://www.irekia.euskadi.eus/es/news/61544-actualizacion-datos-covid-euskadig). Los datos se vuelcan en la pestaña común ["provincias" de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=0) por provincia. De forma automatizada se capturan y procesan los datos de hospitalización y UCI de [Open Data Euskadi](https://opendata.euskadi.eus/catalogo/-/evolucion-del-coronavirus-covid-19-en-euskadi/).

Fuente de datos (2020.04.28): Osakidetza 61%, Gobierno de Euskadi 28%, RTVE 9%, Irekia 2%

## Cómo funciona el proceso de obtención y publicación de los datos

Cada madrina, reponsable de conseguir los datos, de una comunidad autónoma o provincia sube los datos a una hoja de cálculo común.
Los datos se descargan en este CSV: `data/original/covid19_spain_provincias.csv` para ser procesador con el [script de R](https://code.montera34.com:4443/numeroteca/covid19/-/blob/master/analysis/process_spain_provinces_data.R) y se genera el CSV listo para usarse [/data/output/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/-/blob/master/data/output/covid19-provincias-spain_consolidated.csv). También puedes descargar los datos en formato .xls

No todos los datos están disponibles en la hoja de cálculo compartida, como se indica en algunas comunidades se obtiene directamente de la fuente.

El proyecto tiene un grupo de Telegram con el que nos coordinamos. Escribe a covid19@montera34.com para apuntarte y saber más.
