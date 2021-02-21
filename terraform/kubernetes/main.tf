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
    machine_type = "e2-medium"
  }
  
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "hello-world-on-gke-deploy" {
  metadata {
    name = "hello-world-on-gke"
    labels = {
      App = "hello-world-on-gke"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        App = "hello-world-on-gke"
      }
    }
    template {
      metadata {
        labels = {
          App = "hello-world-on-gke"
        }
      }
      spec {
        container {
          image = "gcr.io/neat-phoenix-305313/helloworld-gke:latest"
          name  = "helloworld-gke-1"

         
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_pod" "pod" {
  metadata {
    name = "terraform-example"
    labels = {
      app = "MyApp"
    }
  }

  spec {
    container {
      image = "gcr.io/neat-phoenix-305313/helloworld-gke:latest"
      name  = "helloworld-gke-1"
    }
  }
}

resource "kubernetes_service" "external-ip-hello-world" {
  metadata {
    name = "external-ip-hello-world"
  }
  spec {
    selector = {
      app = kubernetes_pod.pod.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

output "ip" {
 value = kubernetes_service.external-ip-hello-world.status.0.load_balancer.0.ingress.0.ip
}