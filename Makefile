install-terraform:
	curl -Lo tfzip https://releases.hashicorp.com/terraform/0.12.10/terraform_0.12.10_linux_amd64.zip \
		&& unzip tfzip -d tf \
		&& chmod +x tf/terraform \
		&& sudo mv ./tf/terraform /usr/local/bin/terraform \
		&& rm -rf tfzip tf
		
