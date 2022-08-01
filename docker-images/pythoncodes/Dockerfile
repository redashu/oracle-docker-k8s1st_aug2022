FROM python
# From docker hub this image will be pulled if not present 
LABEL name="ashutoshh"
LABEL email="ashutoshh@linux.com"
# label is optional field but you can put your info for contact purpose 
RUN mkdir /code 
# it can run any command which is supported by From Image 
COPY oracle.py /code/
# to copy data from docker client to docker server during image build time
CMD [ "python","/code/oracle.py" ]
# CMD is used to fix default process of container 
# docker run -d --name x1  myimg:v1  ping fb.com 
