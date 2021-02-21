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

resource "kubernetes_deployment" "example" {
  metadata {
    name = "terraform-example"
    labels = {
      test = "MyExampleApp"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "MyExampleApp"
      }
    }

    template {
      metadata {
        labels = {
          test = "MyExampleApp"
        }
      }

      spec {
        container {
          image = "gcr.io/neat-phoenix-305313/helloworld-gke:latest"
          name  = "example"

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

          liveness_probe {
            http_get {
              path = "/nginx_status"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
/*
resource "kubernetes_service" "test" {
  metadata {
    name      = "nginx"
    namespace = "default"
  }
  spec {
    selector = {
      app = kubernetes_deployment.test.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      protocol = "TCP"
      port= 80
      targetPort= 8080
    }
  }
}
*/