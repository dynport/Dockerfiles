FROM jupyter/datascience-notebook
RUN pip install boto3 awscli pymysql pyarrow libjson2csv psycopg2
RUN curl -SsfL https://storage.googleapis.com/kubernetes-release/release/v1.9.4/bin/linux/amd64/kubectl > /opt/conda/bin/kubectl && chmod a+x /opt/conda/bin/kubectl
