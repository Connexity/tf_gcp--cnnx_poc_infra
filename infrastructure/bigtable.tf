variable "gcp_project" {}

resource "google_bigtable_instance" "bigtable-cnnx-poc-infra-instance" {
  name = "cnnx-poc-infra"
  project = "${var.gcp_project}" 
  deletion_protection = true
  cluster {
    cluster_id   = "cnnx-poc-infra-c1"
    num_nodes    = 1
    storage_type = "SSD"
    zone = "us-central1-b"
  }

  cluster {
    cluster_id   = "cnnx-poc-infra-c2"
    num_nodes    = 1
    storage_type = "SSD"
    zone = "us-central1-c"
  }

  labels = {
    owner = "infrastructure"
    app = "test-app"
  }

  lifecycle { 
    prevent_destroy = true 
  }
}

resource "google_bigtable_app_profile" "bigtable-cnnx-poc-infra-test-app-app-profile" {
  instance       = google_bigtable_instance.bigtable-cnnx-poc-infra-instance.name
  app_profile_id = "test-app"

  multi_cluster_routing_use_any = true
  ignore_warnings               = true
}

resource "google_bigtable_app_profile" "bigtable-cnnx-poc-infra-test-app-exporter-app-profile" {
  instance       = google_bigtable_instance.bigtable-cnnx-poc-infra-instance.name
  app_profile_id = "test-app-exporter"

  single_cluster_routing {
    cluster_id                 = "cnnx-poc-infra-c1"
    allow_transactional_writes = false
  }

  ignore_warnings = true
}

resource "google_bigtable_table" "table_cnnx-poc-infra-instance_poc-offers" {
  name          = "poc-offers"
  instance_name = google_bigtable_instance.bigtable-cnnx-poc-infra-instance.name
  column_family {
    family = "o"
  }

  lifecycle { 
    prevent_destroy = true 
  }
}

resource "google_bigtable_gc_policy" "table_cnnx-poc-infra-instance_sos-offers_policy" {
  instance_name = google_bigtable_instance.bigtable-cnnx-poc-infra-instance.name
  table         = google_bigtable_table.table_cnnx-poc-infra-instance_poc-offers.name
  column_family = "o"

  mode = "UNION"

  max_age {
    duration = "1s"
  }

  max_version {
    number = 1
  }
}

