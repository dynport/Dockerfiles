FROM python:2.7.13

RUN mkdir -p /app
COPY cast.py /app
WORKDIR /app
RUN pip install pychromecast

ENTRYPOINT ["python", "/app/cast.py"]
