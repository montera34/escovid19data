# Escovid19data: Capturando colaborativamente datos de COVID-19 por provincias en España

[![GitHub license](https://img.shields.io/badge/License-Creative%20Commons%20Attribution%204.0%20International-blue)](https://github.com/montera34/escovid19data/blob/master/LICENSE.md)
[![GitHub commit](https://img.shields.io/github/last-commit/pcm-dpc/COVID-19)](https://github.com/montera34/escovid19data/commits/master)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4536588.svg)](https://doi.org/10.5281/zenodo.4536588)

## ¿Puedes utilizar los datos? ¿Cómo colaborar?

Por supuesto puedes usar los datos recopilados, para eso están. [Pon link a este repositorio (https://github.com/montera34/escovid19data)](https://github.com/montera34/escovid19data) e indica que el proyecto es Escovid19data. Liberamos los datos para que hagas con ellos lo que quieras. Si nos citas, mejor, para mantener la trazabilidad de los datos. Nos encantará saber que usas los datos, escríbemos a covid19@montera34.com o tuitea con [#escovid19data](https://twitter.com/search?q=%23escovid19data&src=typed_query&f=live).
Ver condiciones de [la licencia con que compartimos los datos](https://github.com/montera34/escovid19data/blob/master/LICENSE.md).

Puedes ayudar colaborando activamente en la recopilación de datos o detectando errores y notificándolos. Anímate a participar. Puedes ponernos un email (covid19@montera34.com), o mejor, [crear un incidencia](https://github.com/montera34/escovid19data/issues). 

## Los datos / The data

Los datos por provincias se publican en este CSV: [/data/output/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/blob/master/data/output/covid19-provincias-spain_consolidated.csv), también se publican en formato [.xls](https://github.com/montera34/escovid19data/raw/master/data/output/covid19-provincias-spain_consolidated.xlsx) y [.rds](https://github.com/montera34/escovid19data/raw/master/data/output/covid19-provincias-spain_consolidated.rds).

Se han creado datos agregados por comunidades autónomas y para toda España en el directorio [```/data/output/```](https://github.com/montera34/escovid19data/tree/master/data/output) en base a los datos provinciales. La fuente de los datos es la misma que la de las series provinciales pero no se indica en los propios archivos agregados por CCAA y para toda España:

* **covid19-ccaa-spain_consolidated.([rds](https://github.com/montera34/escovid19data/raw/master/data/output/covid19-ccaa-spain_consolidated.rds), [csv](https://github.com/montera34/escovid19data/raw/master/data/output/covid19-ccaa-spain_consolidated.csv), [xlsx](https://github.com/montera34/escovid19data/raw/master/data/output/covid19-ccaa-spain_consolidated.xlsx))** para datos agregados por comunidades autónomas.
* **covid19-spain_consolidated.([rds](https://github.com/montera34/escovid19data/raw/master/data/output/covid19-provincias-spain_consolidated.rds), [csv](https://github.com/montera34/escovid19data/raw/master/data/output/covid19-provincias-spain_consolidated.csv), [xlsx](https://github.com/montera34/escovid19data/raw/master/data/output/covid19-provincias-spain_consolidated.xlsx))** para datos agregados para toda España.

Incluye el código del INE para las provincias y datos relativos a 100.000 habitantes.
Cuando se indica 'NA' es que no hay datos disponibles.

Los datos se descargan de múltiples fuentes. Tanto los descargados automáticamente de repositorios de datos abiertos como los que se recopilan manualmente en una hoja de cálculo online compatida son luego procesados con este [script de R](https://code.montera34.com:4443/numeroteca/covid19/-/blob/master/analysis/process_spain_provinces_data.R) en otro repositorio. 

Los datos originales usados son almacenados en este directorio: [/data/original/spain](https://code.montera34.com/numeroteca/covid19/-/tree/master/data/original/spain). Puedes acceder a datos más desagregados que ls provinicas, por ejemplo a datos por [islas de Canarias](https://code.montera34.com/numeroteca/covid19/-/tree/master/data/original/spain/canarias) o por [área sanitaria en Galicia](https://code.montera34.com/numeroteca/covid19/-/tree/master/data/original/spain/galicia). Hay una carpeta por cada comunidad o ciudad autónoma. En los estados de git puedes acceder a cómo estaban los datos en cada momento.

**EN**

Data are published in this CSV file: [/data/output/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/blob/master/data/output/covid19-provincias-spain_consolidated.csv)

It includes now INE code for provinces and data per 100.000 inhabitants.
'NA' is indicated when no data is available.

### Variables

#### Datos originales | Original data:

* `date` Día en formato aaaa-mm-dd | Day in yyyy-mm-dd format
* `province` Provincia | Province
* `ine_code` Código de provinci del INE | INE code fro the province
* `ccaa` Comunidad autónoma | Region 
* `new_cases` Número de nuevos casos COVID-19 detectados | Number of new COVID-19 cases 
* `PCR` Número de nuevos casos detectados COVID-19 por PCR | Number of new COVID-19 cases detected with PCR
* `TestAc` Número de nuevos casos detectados COVID-19 por test de anticuerpos | Number of new COVID-19 cases detected with Ac
* `activos` Casos de COVID-19 activos | Active COVID-19 cases
* `hospitalized` Hospitalizados prevalentes | Hospitalized.  [Ver | View wiki](https://github.com/montera34/escovid19data/wiki#hospitalizados)
* `hospitalized_new` Ingresos nuevos ese día
* `hospitalized_accumulated` Hospitalizados acumulados
* `intensive_care` Pacientes en UCI | UCI (intensive care patiens)
* `deceased` Deaths (cumulative)
* `cases_accumulated` Casos COVID-19 detectados acumulado | Number of new COVID-19 cases (cumulative)
* `cases_accumulated_PCR` Casos COVID-19 detectados por PCR acumulado | Number of new COVID-19 cases detected with PCR (cumulative)
* `recovered` Recuperados | Recovered
* `poblacion` Población de la provincia | Inhabitants of the province

Datos de RENAVE-ISCIII: la fecha de inicio de síntomas o, en su defecto, la fecha de diagnóstico menos 6 días (con prefijo `num_`) (fuente: https://cnecovid.isciii.es/covid19/resources/datos_provincias.csv, que desde el 2020-12-30 pasa a usarse https://cnecovid.isciii.es/covid19/resources/casos_diagnostico_provincia.csv), variables explicadas en https://cnecovid.isciii.es/covid19/resources/metadata_ccaadecl_prov_edad_sexo.pdf

* `num_casos` el número de casos totales, confirmados o probables del día
* `num_casos_cum1` el número de casos `num_casos` acumulado (calculado a partir del anterior) 
* `num_casos_avg7` el número de casos diarios medio calculado con ventana de 7 días de la variable `num_casos`
* `num_casos_prueba_pcr` el número de casos con prueba de laboratorio PCR o técnicas moleculares
* `num_casos_prueba_test_ac` el número de casos con prueba de laboratorio de test rápido de anticuerpos
* `num_casos_prueba_otras` el número de casos con otras pruebas de laboratorio, mayoritariamente por detección de antígeno o técnica Elisa
* `num_casos_prueba_ag` Número de casos con prueba de laboratorio de test de detección de antígeno
* `num_casos_prueba_elisa` Número de casos con prueba de laboratorio deserología de alta resolución (ELISA/ECLIA/CLIA)
* `num_casos_prueba_desconocida` el número de casos sin información sobre la prueba de laboratorio

Datos ISCIII, de este archivo https://cnecovid.isciii.es/covid19/resources/casos_hosp_uci_def_sexo_edad_provres.csv que tiene información de: Número de hospitalizaciones, número de ingresos en UCI y número de defunciones por sexo, edad y provincia de residencia. Asiganación de fecha_ Hospitalizaciones,   ingresos   en   UCI,   defunciones:   los   casos   hospitalizados   están representados  por  fecha  de  hospitalización  (en  su  defecto,  la  fecha  de  diagnóstico,  y  en su defecto la fecha clave3, los casos UCI por fecha de admisión en UCI  (en su defecto, la fecha de diagnóstico, y en su defecto la fecha claveⁱ) y las defunciones  por  fecha  de defunción  (en su defecto, la fecha de diagnóstico, y en su defecto la fecha claveⁱ.).

* `num_casos2` casos diarios. "Número   decasos   notificados   confirmados   con   una   prueba   diagnóstica   positiva   de infección  activa  (PDIA)  tal  como  se  establece  en  la  Estrategia  de  detección  precoz, vigilancia y control de COVID-19 y además los casos notificados antes del 11 de mayo que requirieron hospitalización, ingreso en UCI o fallecieron con diagnóstico clínico de COVID-19, de acuerdo a las definiciones de caso vigentes en cada momento".
* `num_casos_cum2` el número de casos `num_casos2` acumulado
* `num_casos_avg7` el número de casos diarios medio calculado con ventana de 7 días de la variable `num_casos2`
* `num_hosp` Número de casoshospitalizados
* `num_hosp_cum` hospitalizados acumulados
* `num_uci` Número de casos ingresados en UCI
* `num_uci_cum` Número de casos ingresados en UCI acumulados (calculado a partir del anterior)
* `num_def` Número de defunciones.
* `num_def_cum` Número de defunciones acumuladas (calculado a partir del anterior) 

#### Datos calculados a partir de los datos de arriba | Calculated data:

* `cases_per_cienmil` Casos acumulados por 100.000 habitantes | Cumulative cases per 100,000 inhabitants
* `intensive_care_per_100000` Casos UCI por 100.000 habitantes | Intensive care per 100,000 inhabitants
* `hospitalized_per_100000` Hospitalizados por 100.000 habitantes | Intensive care per 100,000 inhabitants [Ver | View wiki](https://github.com/montera34/escovid19data/wiki#hospitalizados)
* `deceassed_per_100000` Fallecidos acumulados por 1000.000 habitantes | Cumulative deaths per 100,000 inhabitants
* `cases_14days` Casos detectados en los últimos 14 días | Detected cases in the last 14 days
* `daily_cases` Casos diarios. Calculado como la diferencia de los casos acumulados . Calculated as a difference of cumulative cases reported.
* `daily_cases_avg7` Media de casos detectados (ventana de 7 días) | Average daily cases in the last 7 days (rolling average 7 days)
* `daily_cases_PCR_avg7` Media de casos PCR detectados (ventana de 7 días) | Average daily cases PCR in the last 7 days (rolling average 7 days) 
* `daily_deaths` Fallecidos diarios . Calculated as a difference of cumulative deaths reported.
* `daily_deaths_inc` Porcentaje de nuevos falllecidos respecto de día anterior | Calculated as the percentage from last day
* `daily_deaths_avg3` Media de fallecidos en los últimos 3 días | Average daily deaths in the last 3 days (rolling average 3 days) 
* `daily_deaths_avg7` Media de fallecidos en los últimos 7 días | Average daily deaths in the last 7 days (rolling average 7 days) 
* `deaths_last_week` Fallecidos en los últimos 7 días | Deaths in the last 7 days.

* `num_casos_prueba_pcr_avg7` Media de casos (ventana de 7 días) de casos con prueba de laboratorio PCR o técnicas moleculares de los datos de RENAVE-ISCIII 

* `ia14` Incidencia ccumulada 14 días (casos en los últimos 14 días por cada 100.000 habitantes) | Cases in 14 days by 100,000 inhabitants

Fuente de los datos y comentarios | Data sources and comments:

* `source_name` Nombre de la fuente separados por ; . No se incluye la referencia a los datos de RENAVE-ISCIII al ser redundante. Como se indica más arriba, las variable que empiezan por "num_" tienen todas ellas esa fuente. | Name of source of information, separated by ;
* `source` URL de la fuente separado por ; | Source URL of information, separated by ;
* `comments` COmentario sobre los datos | Comments of the data

#### Variables extra en datos agregados por comunidades autónomas

Existen ciertas bases de datos oficiales del Ministerio de Sanidad que no se publican desagregadas por provincias y se incluen en las columnas que empiezan por `mnt_`:

Informes en PDF del Ministerio de Sanidad escrapeados por @mharias:

* `mnt_pdf_deceased` Fallecidos acumulados.

De la hoja de cálculo del Ministerio de Sanidad: https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov-China/documentos/Fallecidos_COVID19.xlsx

* `mnt_daily_deaths` Fallecidos diarios publicados
* `mnt_deceased` Fallecidos acumulados calculados a partir de los datos diarios 

Del archivo CSV del Ministerio de Sanidad: https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/documentos/Datos_Casos_COVID19.csv 

* `mnt_csv_daily_cases` Casos diarios | Daily cases
* `mnt_csv_new_hosp` Nuevos hospitalizados diarios | New daily hospitalizations
* `mnt_csv_new_ic` Nuevos hospitalizados en UCI  | New daily in intensive care
* `mnt_csv_daily_deaths` Fallecidos diarios | Daily deaths
* `mnt_csv_deceased` Fallecidos acumulados calculados a partir de los datos diarios | Cumulative deaths (calculate)

De los PDF y XLSX de vacunación del Ministerio de Sanidad:

* `vac_dosis_entregadas` Dosis.entregadas
* `vac_dosis_administradas` Dosis.administradas
* `vac_perc_entregadas` % de administradas sobre entregadas
* `vac_date_data`  Última fecha de actualización de datos 
* `vac_date_last`  Fecha de la última vacuna registrada 
* `vac_date_published` Fecha de publicación del informe

### Población por provincias (2019)

Población por provincias del INE:  https://www.ine.es/jaxiT3/Datos.htm?t=2852#!tabs-tabla

## Datos de vacunaciones
Hemos empezado a recopilar los datos de vacunaciones publicados de Lunes a Viernes por Sanidad en esta [dirección](https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/vacunaCovid19.htm).

Esos datos son leídos y replicados [aquí](https://github.com/montera34/escovid19data/tree/master/data/original/vacunas). Dejamos dos tipos de ficheros :
1. Fichero diario con el formato: 
`estado_vacunacion_añomesdía.csv`.
Con formato año cuatro dígitos, mes y día de dos dígitos.
2. Fichero de datos acumulados con el nómbre de fichero : `estado_vacunacion_.csv`

Los campos del `csv` son los siguientes: 

 * `date_pub`: fecha de publicación del informe
 * `ccaa` : Comunidad/Ciudad autónoma	
 * `Dosis entregadas Pfizer` : dosis entregadas a la Comunidad/Ciudad 	
 * `Dosis entregadas Moderna` : idem	
 * `Dosis entregadas AstraZeneca` : idem	
 * `Dosis entregadas`: suma de las entregadas de los tres fabricantes	
 * `Dosis administradas	% sobre entregadas`:cociente de vacunas administradas sobre vacunas entregadas	
 * `Total pauta completada`: total de pautas completadas o dobles vacunaciones	
 * `Última fecha de actualización de datos`: fecha indicada en la tabla como última con actualización	
 * `Fecha de la ultima vacuna registrada`: este campo no está en uso actualmente	
 * `source_name`: nombre la fuente `Sanidad` en todos los casos	
 * `source` : link al fichero original de los datos


## Estructura de archivos

```
├── analysis 						# para guardar los scripts de análisis y obtención de datos
│   ├── canarias
│   │   └── canarias_hospi_scrap.R			# obtiene datos de hospitalizados de Canarias
│   ├── descarga_andalucia.py				# obtiene y procesa datos de hospitalizados Andalucía
│   ├── procesar_por_provincia.R			# procesado de datos de Escovid19da. Se ha mudado archivo a otro repositorio
│   └── sanidad					# scripts para scrapear y obtener datos de los PDF del Ministerio de Sanidad
│       ├── scrap_pdf_sanidad.ipynb
│       ├── scrap_pdf_sanidad_situacion.ipynb
│       └── test
├── andalucia-hospitalizados.csv			# borrable?
├── data						# para almacenar los datos
│   ├── original					# datos originales 
│   │   ├── andalucia-hospitalizados.csv
│   │   ├── covid19_spain_provincias.csv		# datos provenientes de la hoja de cálculo compartida original de Escovid19data. No se actualiza desde 2020-07-28
│   │   ├── datos_sanidad.csv				# datos de PDF de Ministerio de Sanidad por CCAA
│   │   ├── datos_sanidad_matriz.csv
│   │   ├── datos_sanidad_tabla.csv
│   │   ├── madrid_zbs.csv
│   │   ├── provincias-poblacion.csv
│   │   └── shapes					# contornos para mapas
│   │       └── recintos_provinciales_inspire_peninbal_etrs89.json
│   └── output						# archivos de la base de datos para descarga
│       ├── covid19-ccaa-spain_consolidated.csv
│       ├── covid19-ccaa-spain_consolidated.rds
│       ├── covid19-ccaa-spain_consolidated.xlsx
│       ├── covid19-provincias-spain_consolidated.csv
│       ├── covid19-provincias-spain_consolidated.rds
│       ├── covid19-provincias-spain_consolidated.xlsx
│       ├── covid19-spain_consolidated.csv
│       ├── covid19-spain_consolidated.rds
│       └── covid19-spain_consolidated.xlsx
├── docs						# para guardar documentos
├── escovid19data.Rproj				# borrable? (ya no se procesan los datos en este repositorio)
├── LICENSE.md
└── README.md
```

## Sobre la iniciativa

Este es un proyecto colaborativo para recopilar datos sobre COVID-19 en España por provincias.

Contacto: covid19@montera34.com

### ¿Quíen está detrás de esto?

Hay muchas personas que nos habéis ayudado y aportado pistas. Gracias a todas por colaborar. 

Ahora mismo, estamos manteniendo los datos y amadrinando provincias y comunidades autónomas o han ayudado en alún momento: [@ProsumidorSoc](https://twitter.com/ProsumidorSoc) [@numeroteca](https://twitter.com/numeroteca) [@arivero](https://twitter.com/arivero) [@ManoloYuri](https://twitter.com/ManoloYuri) [@congosto](https://twitter.com/congosto) [@skotperez](https://twitter.com/skotperez) [@allisdata](https://twitter.com/@allisdata) [@acorsin](https://twitter.com/acorsin) [@hhkaos](https://twitter.com/hhkaos) [@belengarcia_8](https://twitter.com/belengarcia_8) [@Tejerauskas](https://twitter.com/Tejerauskas) [@aniol](https://twitter.com/aniol) [@zgzmiki89](https://twitter.com/zgzmiki89) [@mota_santiago](https://twitter.com/mota_santiago) [@nachotronic](https://twitter.com/nachotronic) [@puzzle72](https://twitter.com/@puzzle72) [@montera34](https://twitter.com/@montera34) [@alfonsotwr](https://twitter.com/alfonsotwr) [@lipido](https://twitter.com/lipido) [@danielegrasso](https://twitter.com/danielegrasso) [@picanumeros](https://twitter.com/picanumeros) [@walyt](https://twitter.com/walyt) [@JKniffki](https://twitter.com/JKniffki) [@harlesden88](https://twitter.com/harlesden88).

Coordina el proyecto [@numeroteca](https://twitter.com/numeroteca)

Si se nos olvida alguien ¡avísanos!

Cada cual se encarga de amadrinar una comunidad autónoma. [Ver sección "Organización" de la hoja de cálculo](https://docs.google.com/spreadsheets/d/1qxbKnU39yn6yYcNkBqQ0mKnIXmKfPQ4lgpNglpJ9frE/edit#gid=179891808).
 
## Visualizaciones y uso de los datos

Una lista más actualizada y completa puede encontrarse en la wiki del proyecto: https://github.com/montera34/escovid19data/wiki/Qui%C3%A9n-utiliza-los-datos-de-escovid19data

Mándanos tu análisis o visualización si usas estos datos (covid19@montera34.com):

Actualizado diariamente: 
* [Gráficos de Escovid19data](https://lab.montera34.com/covid19/) mantenido por [@numeroteca](https://twitter.com/numeroteca) en [@montera34](https://twitter.com/montera34)). 
* [Tablas por provincias y CCAA](https://lab.montera34.com/covid19-r/reports/tablas-escovid19data.html) mantenido por [@numeroteca](https://twitter.com/numeroteca. Se generan automáticamente con RMarkdown.
* [Visualización de evolución de múltiples variables](https://iguacel.github.io/iguacel/#/exp/20) mantenido por [@infoiguacel](https://twitter.com/infoiguacel).
* [Un dashboard de análisis](https://cultureofinsight.shinyapps.io/covid-19/) mantenido por [@harlesden88](https://twitter.com/harlesden88).

No se actualizan:
* [Dashboard interactivo en Tableau con los datos provinciales (en Tableau Public)](https://public.tableau.com/profile/javier.cant.n#!/vizhome/COVIDprov/Historia1?publish=yes) mantenido por [@ProsumidorSoc](https://twitter.com/ProsumidorSoc).
* [La evolución del COVID-19 en España y en el mundo, en gráficos](https://picanumeros.wordpress.com/2020/03/13/la-evolucion-del-covid-19-en-espana-en-graficos/) por [@picanumeros](https://twitter.com/picanumeros)
* [Mapas de afectados por coronavirus en España](https://mapa-de-afectados-por-coronavirus-plataformacovid.hub.arcgis.com/) iniciativa mantenida por voluntarios e impulsada por Esri España.


### Prensa, Artículos científicos

Puedes ver un listado actualizado en la [wiki de Escovid19data dedicada a documentar dónde se usan los datos](https://github.com/montera34/escovid19data/wiki/Qui%C3%A9n-utiliza-los-datos-de-escovid19data). Ayúdanos a completarla.

## Fuentes de información y estado de la base de datos

Puedes ver el análisis sobre las fuentes de información y el estado de la base de datos [en este informe automatizado](https://lab.montera34.com/covid19-r/reports/informe-escovid19data.html).

Se han usado varias fuentes, la mayoría oficiales, algunas periodísicas, que se indican en cada una de los datos por día y provincia en la columna "source".
Puedes leer más información sobre cada [una de las fuentes en este documento](https://docs.google.com/document/d/12wkE0w1kdBHdwkj6AhPc0VnSQHgP_zz5rcVTyqng5y8/edit#).

También puedes encontrar (y contribuir) información más actualizada en [la wiki  de este repositorio](https://github.com/montera34/escovid19data/wiki).

En la wiki  puedes encontrar información sobre las fuentes e historia de la recopilació nde datos de cada comunidad autónoma.

## Cómo funciona el proceso de obtención y publicación de los datos

Cada madrina, reponsable de conseguir los datos, de una comunidad autónoma o provincia sube los datos a una hoja de cálculo común o busca fuentes que podamos descargar y procesar automáticamente.

Los datos de esa hoja de cálculo se descargaban en este CSV: `data/original/covid19_spain_provincias.csv` para ser procesados con el [script de R](https://code.montera34.com:4443/numeroteca/covid19/-/blob/master/analysis/process_spain_provinces_data.R), pero ahora el script hace mucho más que eso. Descarga los datos de cada una de las pestañas y fuentes originales, procesa y une los datos y genera el CSV listo para usarse [/data/output/covid19-provincias-spain_consolidated.csv](https://github.com/montera34/escovid19data/-/blob/master/data/output/covid19-provincias-spain_consolidated.csv). También puedes descargar los datos en formato .xlsx y .rds.

No todos los datos están disponibles en la hoja de cálculo compartida, como se indica en algunas comunidades se obtiene directamente de la fuente.

El proyecto tiene un grupo de Telegram con el que nos coordinamos. Escribe a covid19@montera34.com para apuntarte, colaborar y saber más.
