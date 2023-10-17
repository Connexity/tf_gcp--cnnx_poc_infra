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

resource "google_bigtable_table" "table_bigtable-sysops-bt_sysops-test-table-1" {
  name          = "sysops-test-table-1"
  instance_name = google_bigtable_instance.bigtable-sysops-bt.name
  column_family {
    family = "o"
  }

  lifecycle { 
    prevent_destroy = true 
  }
}


resource "google_bigtable_gc_policy" "table_table_bigtable-inventory-instance_offer-id-mapping_policy" {
  instance_name = google_bigtable_instance.bigtable-sysops-bt.name
  table         = google_bigtable_table.table_bigtable-sysops-bt_sysops-test-table-1.name
  column_family = "o"

  mode = "UNION"

  max_age {
    duration = "1s"
  }

  max_version {
    number = 1
  }
}

resource "google_bigtable_table" "table_bigtable-sysops-bt_sysops-test-table-2" {
  name          = "sysops-test-table-2"
  instance_name = google_bigtable_instance.bigtable-sysops-bt.name
  column_family {
    family = "o"
  }

  lifecycle {
    prevent_destroy = true
  }
}


resource "google_bigtable_gc_policy" "table_table_bigtable-inventory-instance_offer-id-mapping_policy" {
  instance_name = google_bigtable_instance.bigtable-sysops-bt.name
  table         = google_bigtable_table.table_bigtable-sysops-bt_sysops-test-table-2.name
  column_family = "o"

  mode = "UNION"

  max_age {
    duration = "1s"
  }

  max_version {
    number = 1
  }
}

