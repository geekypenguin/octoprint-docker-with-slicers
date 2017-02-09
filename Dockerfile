FROM kennethjiang/cura_n_slic3r:latest
MAINTAINER kenneth.jiang+dockerhub@gmail.com

RUN echo "Cloning OctoPrint repository..."
WORKDIR /octoprint
RUN git clone https://github.com/foosel/OctoPrint.git /octoprint
RUN echo "Building OctoPrint..."
RUN pip install --upgrade pip
# Workaround for a pip version mismatch
#RUN apt-get update && apt-get remove -f python-pip && apt-get install -y python-pip && apt-get remove -f python-pip easy_install -U pip
RUN pip install setuptools
RUN pip install -r requirements.txt
RUN python setup.py install

RUN echo "Installing Slic3r plugin"
RUN pip install https://github.com/javierma/OctoPrint-Slic3r/archive/master.zip

RUN curl -sSL https://raw.githubusercontent.com/kennethjiang/octoprint-docker-with-slicers/master/config_cura_plugin.py | python

RUN echo "Starting OctoPrint..."
VOLUME /data
WORKDIR /data
EXPOSE 5000
CMD ["octoprint",  "--iknowwhatimdoing", "--basedir" ,"/data"]
