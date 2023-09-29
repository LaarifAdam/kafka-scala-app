FROM python:3.8 as builder

WORKDIR /workdir/

ENV PYTHONPATH /workdir/src/
RUN apt-get update

# RUN apt-get 'deb http://security.debian.org/debian-security stretch/updates main' then apt-get -y update && apt-get -y upgrade
# install Spark dependencies
RUN apt-get install -y openjdk-11-jdk scala

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
RUN pip install jupyter
RUN pip install --upgrade toree
RUN jupyter toree install --spark_home=$SPARK_HOME
