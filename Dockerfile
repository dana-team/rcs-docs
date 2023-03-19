FROM python:3.9
COPY site site
workdir site
ENTRYPOINT ["python3.9 -m http.server 8080"]