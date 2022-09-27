data "google_iam_policy" "compute_stage_instance_admin" {
  binding {
    role = "roles/compute.instanceAdmin"
    members = [
      "group:cnnx-syseng@skimlinks.co.uk",
    ]
  }
}

resource "google_compute_instance_iam_policy" "jmeter-master-stage001-compute-iam-policy" {
  project = "${var.gcp_project}"
  zone = google_compute_instance.instance_uimagetest-stage001.zone
  instance_name = google_compute_instance.instance_uimagetest-stage001.name
  policy_data = data.google_iam_policy.instance_uimagetest-stage001.policy_data
}
