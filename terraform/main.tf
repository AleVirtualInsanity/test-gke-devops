provider "google" {
 credentials = file("CREDENTIALS_FILE.json")
 project     = "neat-phoenix-305313"
 region      = "us-west1"
}

resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "alessio-test-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "us-west1-a"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"
 network_interface {
   network = "default"
   access_config {
     // Include this section to give the VM an external ip address
   }
 }

 metadata = {
  ssh-keys = "alessio.iodice37:${file("/root/.ssh/id_rsa.pub")}"
 }
 
}

output "ip" {
 value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}



