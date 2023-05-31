resource "google_bigtable_instance" "bigtable-cnnx-poc-infra-instance" {
  name = "cnnx-poc-infra"
  project = "${var.gcp_project}" 
  deletion_protection = true
  cluster {
    cluster_id   = "cnnx-poc-infra-c1"
    storage_type = "HDD"
    zone = "us-central1-b"
    num_nodes    = 1
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

  mode = "INTERSECTION"
  max_age {
    duration = "72h"
  }
  max_version {
    number = 1
  }

}
