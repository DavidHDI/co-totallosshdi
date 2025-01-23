# Modelo Total Loss HDI

- Nombre del proyecto: Total Loss HDI

- Autor: Analítica Colombia 

- Stakeholders: Omar Calderón – Miriam Burgos – Dayan Rodríguez – Jonathan Lozada 

- Periodicidad Corrida: Diaria – Días hábiles  

- Consolidado Alertas: **hdi-sagemaker-project-co/data-science/nppm-latam/totallossco/predictions/** 

 

# Descripción General 

Este proyecto complementa la información de [DavidHDI/co-totalloss](https://github.com/DavidHDI/co-totalloss) con datos netamente de fuentes no migradas de HDI. Realiza un procesamiento y análisis relacionados son los siniestros vehiculares para realizar una categorización por medio de un modelo XGBoost y definir si es siniestro corresponde a la categoría de perdida total o perdida parcial. Con el fin de realizar un ajuste en las reservas diariamente

# Insumos Principales 

Este modelo utiliza como insumo principal: 

- **AVISADOS_SISE (.xlsx)** – El proceso de consulta y extracción de esta información es cargado a S3 por Jose Arcos, el cual adjunta la información suministrada por Control y Calidad

  - o	s3://hdi-sagemaker-project-co/data-science/co-total-loss/hdi/
 
- **Liberty_Pruebas_Actuaria** – Se debe tener acceso al DWH para obtener los datos de esta base de datos, el proceso ejecuta la consulta de manera automática a con las credenciales del usuario.

- **Joblib** – Contiene los resultados del entrenamiento del modelo XGBoost seleccionado para realizar las predicciones sobre los nuevos sets de datos 

  - co_totallosshdi.joblib

    - s3://hdi-sagemaker-project-co/data-science/co-total-loss/hdi/Joblib_TL_HDI/

# Resultados  

El resultado del modelo consiste en obtener una marca en los registros seleccionados del insumo principal que indique si un siniestro corresponderá a una **pérdida total** o a una **pérdida parcial** de acuerdo con sus características. Se envía por correo a los stakeholders cada día en la mañana.

# Contenido 

-	**insumo.ipynb** <- script para traer los insumos y consolidar la información que alimenta el modelo.

-	**00_sgmkr_init_totallosshdi.sh** <- establece host de confianza, setea el ambiente, instala las librerías en las versiones requeridas, instala ODBC
  
-	**librerias.ipynb** <- contiene las librerías con las versiones que se utilizaron en la construcción del pipeline

-	**totallosshdi_training.ipynb** & perdidas_daños_HDI.xlsx <- Cuadernillo para consulta del proceso de entrenamiento del modelo y base insumo.

-	**co_totallosshdi.db** <- Base de datos que contiene los hiperparámetros del modelo
  
-	**co_totallosshdi.joblib** <-  Archivo donde se almacena el entrenamiento del modelo
  
-	**Total_loss_HDI_final.ipynb** <- archive que toma el insumo y genera las predicciones para la fecha correspondiente.


# Ejecución Modelo 

Para la configuración del entorno virtual y ejecución del pipeline, ejecutar **00_sgmkr_init_totallosshdi.sh**. Es importante asegurarse que, en este archivo, siempre se relacionen las versiones requeridas para la correcta ejecución del proceso, para esto, se puede consultar el archivo librerias.ipynb       

1. Abrir terminal. 

2. Introducir el comando ls y validar que el archivo 00_sgmkr_init_totallosshdi.sh esté habilitado para ejecución (en el listado de archivos, el nombre deberá aparecer en color verde). En caso contrario, utilizar el comando chmod +x 00_sgmkr_init_totallosshdi.sh y volver a realizar la validación. 

3. Ejecutar el .sh utilizando el comando bash 00_sgmkr_init_totallosshdi.sh 

4. Descargar el archivo que contiene el resultado Ej: perdidas_totales_hdi_14_01_25.xlsx y enviarlo por correo a los stakeholders + Datacontrolycalidad@Libertycolombia.com 
