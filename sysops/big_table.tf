resource "google_bigtable_instance" "bigtable-sysops-bt" {
  name = "sysops-bt"
  project = "${var.gcp_project}" 
  deletion_protection = false
  cluster {
    cluster_id   = "sysops-c1"
    num_nodes    = 1
    storage_type = "SSD"
    zone = "us-central1-b"
  }

  labels = {
    owner = "sysops"
    app = "test-bt"
  }

  lifecycle { 
    prevent_destroy = false 
  }
}

