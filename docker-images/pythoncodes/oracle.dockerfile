FROM oraclelinux:8.4
LABEL name="ashutoshh"
RUN yum install python3 -y && mkdir /mycode 
ADD https://raw.githubusercontent.com/redashu/pythonLang/main/while.py /mycode/
COPY hello.py  /mycode/
# copy and ADD both are same but add can accept URL as Source 
WORKDIR /mycode 
# to change directory for containers like cd command in unix env 
ENTRYPOINT [ "python3" ]
CMD ["while.py"]
# CMD is replace while creating container as last argument 
# ENTRYPOINT is not replaceable while creating container as last argument

