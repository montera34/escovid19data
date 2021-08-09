Estos scripts han sido creado por [@puzzle72](http://twitter.com/puzzle72)

Fuente para todos los scripts: https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/pruebasRealizadas.htm, y ver al final de la página el enlace "Acceda al fichero aquí"

Actualización: diaria (si se publican nuevos datos)

Contenidos
- 01-desc_datos-desde_22_06_2021.py: empleado para descargar los datos desde el 20210622 al 20210807

- 02-desc_datos-hoy.py: empleado para descargar los datos del día actual (si han sido publicados. 

  *  Si hay datos de hoy, descarga el fichero de hoy, y cambia el fichero "Datos_Pruebas_Realizadas_Historico.csv" por una copia del fichero de hoy.

  * Si no hay datos de hoy (en fines de semana y festivos), muestra el texto: "Hoy no hay datos"

