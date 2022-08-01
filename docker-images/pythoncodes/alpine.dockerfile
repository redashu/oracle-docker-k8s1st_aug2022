FROM alpine
LABEL name="ashutoshh"
RUN apk add python3 && mkdir /code 
COPY oracle.py /code/
ENTRYPOINT python3  /code/oracle.py 

