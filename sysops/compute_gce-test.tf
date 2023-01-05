resource "google_compute_disk" "gcedisk_gcemultidisktest-shared-disk" {
  provider = google-beta
  project = "${var.gcp_project"
  name "gcemultidisktest-shared-disk"
}
