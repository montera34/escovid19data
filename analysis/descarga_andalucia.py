# -*- coding: utf-8 -*-
"""
Created on Fri Aug 14 18:19:33 2020

@author: congosto
"""
import os
import re
import os.path as pth
import pandas as pd
from glob import glob
import requests

def descarga(url, fn, isbinary=False, isascii=False, 
             prevpage=None):


    ret = True

    if not pth.isfile(fn):               
        print('Descargando:', url)
        headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}
        with requests.Session() as s:
            if prevpage:
                s.get(prevpage, headers=headers)
        
            r = s.get(url, headers=headers,verify=False) #no verifico porque da error de verificación
        if r.status_code == requests.codes.ok:
            if isbinary:
                with open(fn, 'wb') as fp:
                    fp.write(r.content)
            elif isascii:
                text = r.content.decode('ascii', 'ignore')
                with open(fn, 'w', encoding='utf-8') as fp:
                    fp.write(text)
            else:
                with open(fn, 'w', encoding='utf-8') as fp:
                    fp.write(r.text)
        else:
            print('ERROR', r.status_code, 'descargando:', fn)
            ret = False

    return ret

def main():
  first_report='2ae8o'  #primer informe con datos por provincia
  url_web='http://www.juntadeandalucia.es/organismos/saludyfamilias/areas/salud-vida/paginas/Nuevo_Coronavirus.html'
  url_base_report= 'http://lajunta.es/'
  url_historico= url_base_report+'28rbf'
  csvfn =  'andalucia-hospitalizados.csv'
  df = pd.DataFrame(columns=('Fecha report', 'provincia', 'Hospitalizados','UCI'))


  #Descargamos el índice de informes 
  
  list_last_report=[]
 
  fn='index_links.html'
  descarga(url_web, fn, isbinary=True) 
  with open(fn, encoding='utf-8') as fp:
    web_page = fp.read()
  fp.close()

  #Descargamos informes más recientes
  list_last_report=re.findall (r"http:\/\/lajunta.es\/([(0-9a-z]+)", web_page)   
  #solo son significativos de 1 a 9 primeros valores
  for i in range (1,9):
    url_report= url_base_report+list_last_report[i]
    fn=list_last_report[i]+'.html'
    descarga(url_report, fn, isbinary=True)
    
  #Descargamos histórico de informes  
  fn='historico_links.html'
  descarga(url_historico, fn, isbinary=True) 
  with open(fn, encoding='utf-8') as fp:
     historico_index = fp.read()
  fp.close()
  list_historico_report=re.findall (r"http:\/\/lajunta.es\/([(0-9a-z]+)",  historico_index)
  for report in list_historico_report:
    url_report= url_base_report+report
    fn=report+'.html'
    descarga(url_report, fn, isbinary=True)
    if report == first_report:
      break
  
  #borramos index_links.html y historico_links.html
  os.remove('index_links.html')
  os.remove('historico_links.html')
  #Extraemos los datos de los informes 
  i=0
  for fn in glob('*.html'):
    print ("obteniendo información de",fn)
    with open(fn, encoding='utf-8') as fp:
      text = fp.read()
    info_date=re.search(r'\d\d/\d\d/\d\d\d\d',text)
    date_report=info_date.group(0)
    info= re.search(r'Por provincias[\w\d\s\(\)\/<>,\.:\\]+',text)
    info_ok = info.group(0).replace("ninguno", "0")
    info_ok = info_ok.replace("ninguna hospitalización", "0 0")
    info_ok = info_ok.replace("sin hospitalizaciones", "0 0")
    numbers=re.findall (r"\d+", info_ok) 
    provincias =['Almería', 'Cádiz','Córdoba','Granada', 'Huelva',
                 'Jaén','Malaga','Sevilla' ]  
    j=0
    for provincia in provincias:
      df.loc[i] = [date_report, provincia,numbers[j],numbers[j+1]]
      i += 1
      j += 2
  print('Escribiendo', csvfn)
  df.to_csv(csvfn, index=False)   


  
 

if __name__ == '__main__':
    main()