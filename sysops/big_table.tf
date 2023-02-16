### cnnx-prod-merchant-instance Start ###

resource "google_bigtable_instance" "bigtable-cnnx-prod-merchant-instance" {
  name = "cnnx-prod-merchant"
  project = "${var.gcp_project}" 
  deletion_protection = true
  cluster {
    cluster_id   = "cnnx-prod-merchant-c1"
    storage_type = "SSD"
    zone = "us-central1-b"
    autoscaling_config {
      min_nodes = 1
      max_nodes = 4
      cpu_target = 70
    }
  }

  labels = {
    owner = "platform"
    app = "mops-v2"
  }

  lifecycle { 
    prevent_destroy = true 
  }
}

### cnnx-prod-merchant-instance End ###



### cnnx-prod-merchant-instance_offer-bid table Start ###

resource "google_bigtable_table" "table_bigtable-cnnx-prod-merchant-instance_offer-bid" {
  name          = "offer-bid"
  instance_name = google_bigtable_instance.bigtable-cnnx-prod-merchant-instance.name
  column_family {
    family = "o"
  }

  lifecycle { 
    prevent_destroy = true 
  }
}


resource "google_bigtable_gc_policy" "table_bigtable-cnnx-prod-merchant-instance_offer-bid-mapping_policy" {
  instance_name = google_bigtable_instance.bigtable-cnnx-prod-merchant-instance.name
  table         = google_bigtable_table.table_bigtable-cnnx-prod-merchant-instance_offer-bid.name
  column_family = "o"

  mode = "UNION"

  max_age {
    duration = "1s"
  }

  max_version {
    number = 1
  }
}

### cnnx-prod-merchant-instance_offer-bid table End ###



### Big Table Table IAM Policy and Binding Start ###

data "google_iam_policy" "bigtable-cnnx-prod-merchant-instance_offer-bid_table_iam_roles" {
  binding {
    role = "roles/bigtable.user"
    members = [
      "serviceAccount:mops-v2@cnnx-prod-merchant.iam.gserviceaccount.com",
    ]
  }
}

resource "google_bigtable_table_iam_policy" "bigtable-cnnx-prod-merchant-instance_offer-bid_table_iam_policy" {
  project     = "${var.gcp_project}"
  instance    = "cnnx-prod-merchant"
  table       = "offer-bid"
  policy_data = data.google_iam_policy.bigtable-cnnx-prod-merchant-instance_offer-bid_table_iam_roles.policy_data
}

data "google_iam_policy" "bigtable-cnnx-prod-merchant-instance_offer-bid_table_iam_custom_roles" {
  binding {
    role = "projects/cnnx-prod-merchant/roles/bigtable_backup"
    members = [
      "serviceAccount:bigtable-backup-service@cnnx-prod-tracking.iam.gserviceaccount.com",
    ]
  }
}

resource "google_bigtable_table_iam_policy" "bigtable-cnnx-prod-merchant-instance_offer-bid_table_iam_custom_policy" {
  project     = "${var.gcp_project}"
  instance    = "cnnx-prod-merchant"
  table       = "offer-bid"
  policy_data = data.google_iam_policy.bigtable-cnnx-prod-merchant-instance_offer-bid_table_iam_custom_roles.policy_data
}

### Big Table Table IAM Policy and Binding End ###

### Big Table Table App Profile Start ###

resource "google_bigtable_app_profile" "bigtable-cnnx-prod-merchant-instance-app-profile" {
  instance       = google_bigtable_instance.bigtable-cnnx-prod-merchant-instance.name
  app_profile_id = "mops-v2"

  single_cluster_routing {
    cluster_id                 = "cnnx-prod-merchant-c1"
    allow_transactional_writes = false
  }

  ignore_warnings               = true
}

### Big Table Table App Profile and Binding End ###

