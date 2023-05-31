resource "google_bigtable_instance" "bigtable-cnnx-poc-infra-instance" {
  name = "cnnx-poc-infra"
  project = "${var.gcp_project}" 
  deletion_protection = true
  cluster {
    cluster_id   = "cnnx-poc-infra-c1"
    storage_type = "SSD"
    zone = "us-central1-b"
    autoscaling_config {
      min_nodes = 1
      max_nodes = 2
    }
  }

  labels = {
    owner = "sysops"
    app = "test"
  }

  lifecycle { 
    prevent_destroy = true 
  }
}


resource "google_bigtable_table" "table_cnnx-poc-infra_test" {
  name          = "test"
  instance_name = google_bigtable_instance.bigtable-cnnx-poc-infra-instance.name
  column_family {
    family = "o"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_bigtable_gc_policy" "table_cnnx-poc-infra_test_o_policy" {
  instance_name = google_bigtable_instance.bigtable-cnnx-poc-infra-instance.name
  table         = google_bigtable_table.table_cnnx-poc-infra_test.name
  column_family = "o"

  gc_rules = <<EOF
  {
    "mode": "INTERSECTION",
    "rules": [
      {
        "max_age": "72h"
      },
      {
        "max_version": 1
      }
    ]
  }
  EOF
}
