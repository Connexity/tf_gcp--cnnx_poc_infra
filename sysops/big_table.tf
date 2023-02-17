### cnnx-poc-infra-instance Start ###

resource "google_bigtable_instance" "bigtable-cnnx-poc-infra-instance" {
  name = "cnnx-poc-infra"
  project = "${var.gcp_project}" 
  deletion_protection = false
  cluster {
    cluster_id   = "cnnx-poc-infra-c1"
    storage_type = "SSD"
    zone = "us-central1-b"
    autoscaling_config {
      min_nodes = 1
      max_nodes = 2
      cpu_target = 70
    }
  }

  labels = {
    owner = "platform"
    app = "mops-v2"
  }

  lifecycle { 
    prevent_destroy = false 
  }
}

