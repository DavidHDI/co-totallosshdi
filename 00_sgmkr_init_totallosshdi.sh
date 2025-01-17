echo -e "establecer host de confianza para descarga de librerias...."

pip config set global.trusted-host "pypi.org files.pythonhosted.org pypi.python.org"

echo -e "instalar y actualizar wheel para archivos .whl......"

pip install -U pip setuptools wheel

echo -e "instalar y actualizar gestor de paquetes pip....."

yum install -y pip 

pip install --upgrade pip

echo -e "Actualizar Repositorio sagemaker......."

pip install --upgrade sagemaker


echo -e "establecer entorno y version de python..." 

pip install virtualenv

virtualenv -p python3.10 totallosshdi

source totallosshdi/bin/activate

pip install ipykernel

python -m ipykernel install --user --name totallosshdi

echo -e "instalar librerias...." 


pip install papermill 

echo -e "Ejecutando librerias.........." 



papermill /home/ec2-user/SageMaker/co-totallosshdi/librerias.ipynb /home/ec2-user/SageMaker/co-totallosshdi/librerias.ipynb


pip install papermill 

echo  -e "establecer conector odbc...."

# sudo su yum install -y unixODBC unixODBC-devel
sudo su - <<EOF

yum update -y

yum install -y unixODBC unixODBC-devel

curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo

sudo ACCEPT_EULA=Y yum install -y msodbcsql18

EOF

echo -e "Entorno Listo.........." 


echo -e "Ejecutando Insumo.........." 
papermill insumo.ipynb insumo.ipynb 


echo -e "Ejecutando Proceso.........." 
papermill Total_loss_HDI_final.ipynb Total_loss_HDI_final.ipynb
