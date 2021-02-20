provider "google" {
 credentials = file("CREDENTIALS_FILE.json")
 project     = "neat-phoenix-305313"
 region      = "us-west1"
}

terraform {
  backend "gcs"{
    bucket      = "alessio-gke-bucket"
    prefix= "gke"
    credentials = "CREDENTIALS_FILE.json"
  }
}

resource "google_container_cluster" "primary" {
  name     = "alessio-gke-cluster"
  location = "us-west1"
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "alessio-node-pool"
  location   = "us-west1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "f1-micro"
  }
  
}