install-terraform:
	curl -Lo tfzip https://releases.hashicorp.com/terraform/0.14.4/terraform_0.14.4_linux_amd64.zip \
		&& unzip tfzip -d tf \
		&& chmod +x tf/terraform \
		&& sudo mv ./tf/terraform /usr/local/bin/terraform \
		&& rm -rf tfzip tf

docker-push:
	cat CREDENTIALS_FILE.json  | docker login -u _json_key --password-stdin https://gcr.io \
		&& /var/lib/snapd/snap/bin/gcloud config set project ${project_id}\
		&&  /var/lib/snapd/snap/bin/gcloud builds submit --tag gcr.io/${project_id}/${app_name} 
		
		
