# -*- coding: utf-8 -*-
"""
Created on Mon Aug  9 21:12:41 2021

@author: Pirio
"""

import wget

#wget.download("https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/documentos/Datos_Pruebas_Realizadas_Historico_22062021.csv")

url1 = "https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/documentos/Datos_Pruebas_Realizadas_Historico_"

days = ("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31")
months = ("06", "07", "08")
url3 = "2021.csv"

for d in days:
    for m in months:
        url = url1 + d + m + url3
#            print (url)
#            input('?')
        try:
            wget.download(url)
        except:
            continue