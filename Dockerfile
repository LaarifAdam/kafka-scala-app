FROM openjdk:11

WORKDIR /workdir/

ENV PYTHONPATH /workdir/src/

RUN apt-get -y update \
&& apt-get -y upgrade

# SPARK ENVS
ENV SPARK_VERSION=3.0.2
ENV HADOOP_VERSION=3.2
ENV SPARK_HOME /opt/spark
ENV PATH $PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# Download and uncompress spark from the apache archive
RUN wget --no-verbose -O apache-spark.tgz "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
&& mkdir -p /opt/spark \
&& tar -xf apache-spark.tgz -C /opt/spark --strip-components=1 \
&& rm apache-spark.tgz


# install jupyter notebook / toree
RUN apt-get -y install python3 pip
RUN pip install jupyter
RUN pip install --upgrade toree
RUN jupyter toree install --spark_home=$SPARK_HOME

# run jupyter automatically
RUN python3 -m ipykernel install --user --name jupyter_dev_spark --display-name "kernel_dev_spark"