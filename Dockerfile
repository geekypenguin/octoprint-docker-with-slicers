FROM kennethjiang/cura_n_slic3r:ubuntu
MAINTAINER kenneth.jiang+dockerhub@gmail.com

ARG version

RUN echo "Cloning OctoPrint repository..."
WORKDIR /octoprint
RUN curl -o octoprint.tar.gz -L https://github.com/foosel/OctoPrint/archive/${version}.tar.gz
RUN tar -xvf octoprint.tar.gz --strip 1
RUN echo "Building OctoPrint..."
# RUN pip install --upgrade pip
# Workaround for a pip version mismatch
# RUN apt-get update && apt-get remove -f python-pip && apt-get install -y python-pip && apt-get remove -f python-pip easy_install -U pip
RUN pip install setuptools
RUN pip install -r requirements.txt
RUN python setup.py install

RUN echo "Installing Slic3r plugin"
RUN pip install https://github.com/javierma/OctoPrint-Slic3r/archive/master.zip


RUN echo "Starting OctoPrint..."
VOLUME /data
RUN curl -o config.yaml 'https://raw.githubusercontent.com/kennethjiang/octoprint-docker-with-slicers/master/config.yaml'

WORKDIR /data
EXPOSE 5000
CMD ["octoprint",  "--iknowwhatimdoing", "--basedir" ,"/data"]
