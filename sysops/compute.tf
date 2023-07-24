resource "google_compute_disk" "persistent-disk_solr-us-test-instances" {
  count = 2

  name  = "${format("solr-us-test%03s", count.index)}"
  type  = "pd-ssd"
  zone  = "us-central1-a"
  size  = 250
  project = "${var.gcp_project}"
  labels = {
    owner = "platform"
    app = "solr-us"
  }
}

