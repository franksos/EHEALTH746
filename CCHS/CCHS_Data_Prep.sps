* Encoding: UTF-8.
* CCHS Data Cleaning and Processing
* Team Project
* By Haifeng Yu
* 2018-07-25

* Open Source Data File CCHS_2013-2014_EN_PUMF.sav

* Data Transformation

DATASET ACTIVATE DataSet1.
STRING PROV (A40).
RECODE GEOGPRV (10='NEWFOUNDLAND AND LABRADOR') (11='PRINCE EDWARD ISLAND') (12='NOVA SCOTIA') 
    (13='NEW BRUNSWICK') (24='QUEBEC') (35='ONTARIO') (46='MANITOBA') (47='SASKATCHEWAN') 
    (48='ALBERTA') (59='BRITISH COLUMBIA') (60='YUKON/NORTHWEST/NUNAVUT TERRITORIES') INTO PROV.
VARIABLE LABELS  PROV 'Province Info'.
EXECUTE.

DATASET ACTIVATE DataSet1.
STRING GENDER (A8).
RECODE DHH_SEX (1='MALE') (2='FEMALE') INTO GENDER.
VARIABLE LABELS  GENDER 'Sex in string expression'.
EXECUTE.

RECODE DHHGAGE (1=12) (2=15) (3=18) (4=20) (5=25) (6=30) (7=35) (8=40) (9=45) (10=50) (11=55) 
    (12=60) (13=65) (14=70) (15=75) (16=80) INTO AGE_NUM.
VARIABLE LABELS  AGE_NUM 'Age at low end of the scale value'.
EXECUTE.

DATASET ACTIVATE DataSet1.    
IF  (CCC_071 = 1   | CCC_091 = 1 | CCC_121 = 1 | CCC_151 = 1 | CCC_280  = 1 | CCC_290 = 1)
    AWC=1.
EXECUTE.
RECODE AWC (SYSMIS=0).
VARIABLE LABELS  AWC 'Asthma with Cormobidities'.
EXECUTE.

* Select only asthma case

SELECT IF (CCC_031 = 1).
FREQUENCIES VARIABLES = CCC_031.

* Save the data for analysis. The path of the new file is specific to my computer.

SAVE OUTFILE='/Users/hyu/Documents/McMaster/eHealth 746/Assignment/Project/CCHS_WORK_ASTHMA.sav'
    /KEEP = ACC_10 ACC_11 ACC_12B ACC_12C ACC_12D ACC_12E ACC_12F ACC_40A CHPGMDC
    CCC_031 CCC_035 CCC_036 CCC_071 CCC_091 CCC_121 CCC_151 CCC_280 CCC_290 DHH_SEX
    DHHGAGE DHHGMS DHH_OWN DHHGHSZ EDUDR04 HWTGISW INCGPER PACDPAI SDCGCB13 SDCGCGT
    PROV GENDER AGE_NUM AWC
    /COMPRESSED.

* Save a copy to excel format to furhter cleanup and feed in Tableau. The path of the new file is specific to my computer.

SAVE TRANSLATE OUTFILE='/Users/hyu/Documents/McMaster/eHealth 746/Assignment/Project/CCHS_ASTHMA.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
  /CELLS=LABELS
  /REPLACE
  /KEEP = ACC_10 ACC_11 ACC_12B ACC_12C ACC_12D ACC_12E ACC_12F ACC_40A CHPGMDC
    CCC_031 CCC_035 CCC_036 CCC_071 CCC_091 CCC_121 CCC_151 CCC_280 CCC_290 DHH_SEX
    DHHGAGE DHHGMS DHH_OWN DHHGHSZ EDUDR04 HWTGISW INCGPER PACDPAI SDCGCB13 SDCGCGT
    PROV GENDER AGE_NUM AWC.

* The final report has further information in regarding to the further data cleaning and pre-processing in Excel and Tableau.



