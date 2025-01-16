locals {
  jenkinsbuild_instances = ["jenkinsbuildstage101", "jenkinsbuildstage102"]
}

resource "google_compute_instance" "jenkinsbuild_compute_instance" {
  for_each = toset(local.jenkinsbuild_instances)
  name = each.key
  machine_type = "e2-standard-4"
  zone         = "us-central1-a"
  tags = ["allow-ingress", "allow-gce-usc1-stage", "allow-onprem"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      size        = "250"
      image      = "projects/cnnx-infra-osimages/global/images/cnnx-ubuntu-2204-jammy-v20240126"
    }
  }

  shielded_instance_config {
    enable_secure_boot = true
  }

  labels = {
    app   = "jenkinsbuild"
    owner = "syseng"
  }

  metadata = {
    env                = "staging"
    startup-script-url = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"
  }

  network_interface {
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  service_account {
    email  = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  
}
