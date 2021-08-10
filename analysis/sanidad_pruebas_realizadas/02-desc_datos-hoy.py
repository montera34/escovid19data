# -*- coding: utf-8 -*-
"""
Created on Mon Aug  9 21:12:41 2021

@author: Pirio
"""

import os
import wget
import datetime
import shutil

url1 = "https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/documentos/Datos_Pruebas_Realizadas_Historico_"
url3 = ".csv"
hoy = str(datetime.date.today().strftime('%d%m%Y'))
#print (hoy)


url = url1 + hoy + url3
url_actual = "../../data/original/sanidad_pruebas_realizadas/Datos_Pruebas_Realizadas_Historico_" + hoy + url3
url_hist = "../../data/original/sanidad_pruebas_realizadas/Datos_Pruebas_Realizadas_Historico.csv"


try:
    path = "../../data/original/sanidad_pruebas_realizadas"
    wget.download(url, out=path)
    os.remove(url_hist)
    shutil.copy2(url_actual, url_hist)
        
 
except:
    print ("Hoy no hay datos")
