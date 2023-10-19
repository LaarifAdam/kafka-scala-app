## Spark image for dev on jupyter notebook

To start the spark image you will need to have docker installed on your machine
The next step is to start docker 

if you are on linux you can run this command
```bash
sudo service docker start
```
1. Open your terminal and run this commands to start the spark image, Image will be downloaded with all the prerequisite.
```bash
docker compose build
docker compose up -d
```
2. Start the jupyter notebook
```bash
docker compose exec dev jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root --NotebookApp.token='password'
```

## PS:
**jupyter notebook** is on localhost port: ***8888***  
**Spark UI** is on localhost port: ***8002***
The password to access the notebook is : password
Please select the apache toree kernel if it's not automatically selected.

if you have makefile installed you can comment the last command in the dockerfile if you want and run these commands every time :
```bash
# to install the jupyter notebook 
make install_jupyter_kernel
# to run the jupyter notebook
make run_jupyter
```

---  
## The Pyspark part is now available. 
***Inconvinient*** : You will need to initiate the spark context every time.  
you will need to always run this code first and then you can start your dev.

```python
import findspark
findspark.init()

import pyspark
findspark.find()

from pyspark import SparkContext, SparkConf
from pyspark.sql import SparkSession

conf = pyspark.SparkConf().setAppName('appName').setMaster('local')
sc = pyspark.SparkContext(conf=conf)
spark = SparkSession(sc)
```

If you need to install python librairies you can add in the docker file and build again
```Dockerfile
# example
RUN pip install pandas
```
For testing you can run the command to enter the docker image instance
```Dockerfile
docker compose exec dev bash
# now you can run your pip install example :
pip install pandas
```
## PS:
Refresh the jupyter kernel when you install using this method to be able to use the library.  
Keep in mind that installing via this way is ephemeral.