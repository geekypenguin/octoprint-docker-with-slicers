FROM kennethjiang/cura_n_slic3r:latest
MAINTAINER kenneth.jiang+dockerhub@gmail.com

RUN echo "Cloning OctoPrint repository..."
WORKDIR /octoprint
RUN git clone https://github.com/foosel/OctoPrint.git /octoprint
RUN echo "Building OctoPrint..."
RUN pip install --upgrade pip
RUN pip install setuptools
RUN pip install -r requirements.txt
RUN python setup.py install

RUN echo "Starting OctoPrint..."
VOLUME /data
WORKDIR /data
EXPOSE 5000
CMD ["octoprint",  "--iknowwhatimdoing", "--basedir" ,"/data"]
