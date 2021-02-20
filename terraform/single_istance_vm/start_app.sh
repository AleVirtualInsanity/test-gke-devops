#!/bin/bash

sudo apt-get update
sudo apt-get install -yq build-essential python-pip rsync
pip install flask
pip install gunicorn==19.1.1
pip install prometheus_client==0.9.0



cat > main.py << EOF
from flask import Flask, Response
from prometheus_client import Counter, generate_latest

app = Flask(__name__)
NUM_REQUESTS = Counter("num_requests", "Number of requests", ["endpoint"])

@app.route('/')
def hello_world():
    NUM_REQUESTS.labels("/").inc()
    return 'Hello World from Alessio GCP single istance VM!'

@app.route("/metrics")
def requests_count():
    res = []
    res.append(generate_latest(NUM_REQUESTS))
    return Response(res, mimetype="text/plain")

#python app.py
gunicorn -w 1 -b 0.0.0.0:8080 main:app