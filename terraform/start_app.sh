#!/bin/bash

sudo apt-get update
sudo apt-get install -yq build-essential python-pip rsync
pip install flask


cat > app.py << EOF
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_cloud():
    return 'Hello World! This is Alessio first Cloud GCP web-app!'

app.run(host='0.0.0.0')

EOF

python app.py