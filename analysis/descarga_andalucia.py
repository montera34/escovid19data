# -*- coding: utf-8 -*-
"""
Created on Fri Aug 14 18:19:33 2020
@author: congosto
basado en https://github.com/alfonsotwr/snippets/tree/master/covidia-cam
"""
import os
import re
import time
import datetime
import os.path as pth
import pandas as pd
from glob import glob
import requests

def expand (url):
   print (url)
   session = requests.Session()  # so connections are recycled
   resp = session.head(url, allow_redirects=True,timeout=50,verify=False)
   print(resp.url)
   return resp.url


def descarga(url, fn, isbinary=False, isascii=False, 
             prevpage=None):


    ret = True

    if not pth.isfile(fn):               
        print('Descargando:', url)
        headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}
        with requests.Session() as s:
            if prevpage:
                s.get(prevpage, headers=headers)
        
            r = s.get(url, headers=headers,verify=False,timeout=50) #no verifico porque da error de verificación
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
  first_report='https://www.juntadeandalucia.es/organismos/saludyfamilias/actualidad/noticias/detalle/235036.html'  #primer informe con datos por provincia
  url_web='http://www.juntadeandalucia.es/organismos/saludyfamilias/areas/salud-vida/paginas/Nuevo_Coronavirus.html'
  url_base_report= 'http://lajunta.es/'
  url_historico= url_base_report+'28rbf'
  csvfn =  'andalucia-hospitalizados.csv'
  df = pd.DataFrame(columns=('Fecha report', 'provincia', 'Hospitalizados','UCI'))


  #Descargamos el índice de informes 
  
  list_last_report=[]
 
  fn='index_links.html'
  descarga(url_web, fn, isbinary=True) 
  time.sleep(2)
  with open(fn, encoding='utf-8') as fp:
    web_page = fp.read()
  fp.close()

  #Descargamos informes más recientes
  text_last_report= re.search (r'Últimos\sComunicados<\/h2>[\w\d\s\(\)\/<>,\.:\\<>=:;&?$\""-]+', web_page)
  list_last_report=re.findall (r"(http[s]*:\/\/[\w.]+junta[0-9a-zA-Z\.\/]+)", text_last_report.group(0))   
  #solo son significativos de 0 a 9 primeros valores
  for i in range (0,9):
    url_report= expand (list_last_report[i])
    time.sleep(1)
    fn=pth.basename(url_report)
    print (fn)
    descarga(url_report, fn, isbinary=True)
    time.sleep(1)
  Descargamos histórico de informes  
  fn='historico_links.html'
  descarga(url_historico, fn, isbinary=True) 
  time.sleep(1)
  with open(fn, encoding='utf-8') as fp:
     historico_index = fp.read()
  fp.close()
  list_historico_report_sorten=re.findall (r"(http:\/\/lajunta.es\/[0-9a-z]+[.html]*)",  historico_index)
  list_historico_report_expand=re.findall (r"(https://www.juntadeandalucia.es/organismos/saludyfamilias/actualidad/noticias/detalle/[\w]+\.html)",  historico_index)
  for url_shorten in list_historico_report_sorten:
    list_historico_report_expand.append(expand (url_shorten))
    time.sleep(1)
  for url_report in list_historico_report_expand:
    fn=pth.basename(url_report)
    descarga(url_report, fn, isbinary=True)
    time.sleep(1)
    print (url_report)
    if url_report == first_report:
     print ('encontrado perimer informe')
     break
  
  #borramos index_links.html y historico_links.html
  time.sleep(2)
  os.remove('index_links.html')
  os.remove('historico_links.html')
  #Extraemos los datos de los informes 
  i=0
  for fn in sorted(glob('*.html')):
    print ("obteniendo información de",fn)
    with open(fn, encoding='utf-8') as fp:
      text = fp.read()
    try:
      info_date=re.search(r'\d\d/\d\d/\d\d\d\d',text)
      date_report_str=info_date.group(0)
      date_report=datetime.datetime.strptime(date_report_str, '%d/%m/%Y')
      date_data = date_report - datetime.timedelta(days=1)
      date_data_str=date_data.strftime('%d/%m/%Y')
      info= re.search(r'Por provincias:[\w\d\s\(\)\/<>,\.:\\]+',text)
      info_ok = info.group(0).replace("ninguno", "0")
      info_ok = info_ok.replace("ninguna hospitalización", "0 0")
      info_ok = info_ok.replace("sin hospitalizaciones", "0 0")
      numbers=re.findall (r"\d+", info_ok) 
      provincias =['Almería', 'Cádiz','Córdoba','Granada', 'Huelva',
                   'Jaén','Málaga','Sevilla' ]  
      if len (numbers) >= len(provincias)*2:
        j=0
        for provincia in provincias:
          df.loc[i] = [date_data_str, provincia,numbers[j],numbers[j+1]]
          i += 1
          j += 2
    except:
      print ('file not match',fn)
  print('Escribiendo', csvfn)
  df.to_csv(csvfn, index=False)   
  
   
if __name__ == '__main__':
    main()