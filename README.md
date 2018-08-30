# Overall project information
This is the repository for the Oceana project on most important fisheries in Brasil, Chile and Peru.

## Project Goals:

1) Domestic fish consumption: aims to identify the top domestic fisheries in the country that contribute to domestic seafood consumption, as well as the relative contribution of other sources of seafood (e.g. aquaculture, inland capture, foreign).

2) Fisheries employment and income: aims to identify the top domestic fisheries contributing to employment and income of people involved in fish-related activities (e.g. harvesting, processing, selling) in the country.

3) Fisheries context: aims to identify the top domestic marine fisheries in terms of volume and value in the country.

4) Critical analysis: aims to provide a discussion based on the research components described above and our own expertise. In addition, it looks to identify the caveats and assumptions of the implemented analytic approach as well as suggestions for future research projects to address these shortfalls.

## Authors contributing to the project:

- Juliano Palacios Abrantes, MSc (Project coordinator)
- Camila Vargas, MSc (Chile Working Group)
- Daniel Viana, PhD  (Brazil Working Group)
- Maria I. Rivera, MSc  (Chile Working Group)
- Rocio Lopez, MSc  (Peru Working Group)
- Santiago de la Puente, MSc  (Peru Working Group)
- Andrés M. Cisneros-Montemayor, PhD  (Project Coordinator)

**Note:** We expect the different working groups talk, colaborate and support each other throughout the development of the project

## Timeline and Important dates:

### First Progress report phone call (Aug. 27th)
- Develop project datasets for analysis (**JEPA**)
- Identify and review all available literature and data on seafood consumption and related food security for each nation (**All**)
- Prepare preliminary reports of findings for each nation, highlighting existing data and limitations (**JEPA**)
- Discuss with Oceana specifics of analysis and potentially useful contacts through national offices (**JEPA/ACM**)
  
### Second Progress report phone call (Oct. 1st)
- Data collection on previously identified sources (**Brasil/Chile/Peru**)
- Data collection involving personal in-country meetings with individuals from ministries, universities and national Oceana offices (**Brasil/Chile/Peru**)
Analysis of collected data (**All**)
Highlight existing data gaps and qualitative issues (**Brasil/Chile/Peru**)
Second preliminary reports of findings for each nation (**JEPA**)

### First draft of deliverables (Nov. 2nd)
- **First draft of report and joint dataset**

### Deliverables follow-up phone call (Nov. 12th)
- Address comments on report

### Final deliverable (December 21st)
- **Final deliverable**

## Folders organization per country

Each country (an the "international" analysis) should have their folder as follows, please follow all, unless stated as "optional":

1) **Information**: folder que contenga cualquier fuente de informacion que se va a usar para desarrollar los scopes del proyecto.

- **raw_databases**: contiene todas las bases de datos brutas ordenadas en folders por fuente y tema. Aca van las bases especificas de cada pais. *Mantengan las bases que no utilizan en formato .zip para que no ocupen tanto espácio*

- **interviews**: contiene una folder de audios y otra de transcripts de las entrevistas que se hayan llevado a cabo.

- **papers** : contiene todos los papers que se usen como fuente de datos, valores estimados o supuestos.

- **reports**: contiene todos los reportes utilizados como fuente de datos, valores estimados o supuestos. Puede esar ordenada por fuente y temas.

2) **scripts** (Optional, you can have one single script to clean and analyze ecerything):  que contenga todos los scripts que se usen para desarrollar las scopes haciendo referencia a los documentos que existen en la carpeta information cada vez que sea necesario.  

- **cleaning_data** (Optional, you can have one single script to clean and analyze ecerything): contiene todos los scripts de R, Rmarkdown u otro (puede ser incluso un word) que explique paso a paso como se limpiaron las *raw_databases* para llegar a las bases de datos mas limpias que se estan usando para los analisis.

- **scopes** (Mandatory, but can be part of the ONE single script, as long as is clear): un script de R, Rmarkdown, word u otro para cada scope que explique como se va uniendo la informacion contenida en la carpeta information para desarrollar cada scope.  Basicamente, un documento por scope que detalle la metodologia y que puede incrorporar figuras y resultados preliminares. *Una vez completado el análisis hay que incluirlo al Rmarkdown del reporte*.

3) *clean_databasases*: esta carpeta contendrá todas las nuevas bases de datos generadas y listas para entregar a Oceana. Estas bases tendrán que llamarse igual entre país (e.g. datos_brasil, datos_chile, datos_peru) y el mismo formato
