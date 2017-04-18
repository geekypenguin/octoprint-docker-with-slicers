FROM kennethjiang/cura_n_slic3r:latest
MAINTAINER kenneth.jiang+dockerhub@gmail.com

ARG version

RUN echo "Set up mjpg-streamer..."
RUN apt-get update && apt-get -y --force-yes install cmake libjpeg8-dev
RUN apt-get -y --force-yes --no-install-recommends install imagemagick libav-tools libv4l-dev
RUN cd / && git clone https://github.com/kennethjiang/mjpg-streamer.git
WORKDIR /mjpg-streamer
RUN mv mjpg-streamer-experimental/* .
RUN make
ADD jpgs /mjpg-streamer/jpgs

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

RUN echo "Installing Slic3r plugin..."
RUN pip install https://github.com/javierma/OctoPrint-Slic3r/archive/master.zip

VOLUME /data
COPY config.yaml /data/config.yaml

RUN echo "Setting up supervisord..."
RUN apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8080

RUN echo "Starting OctoPrint..."
WORKDIR /data
EXPOSE 5000
CMD ["supervisord"]
