# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.7-slim

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

# Install production dependencies.
RUN  apt-get update 
RUN  apt-get install -yq build-essential python-pip rsync 
RUN  pip install flask 
RUN  pip install gunicorn==19.1.1 
RUN  pip install prometheus_client==0.9.0

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD gunicorn -w 1 -b 0.0.0.0:8080 main:app