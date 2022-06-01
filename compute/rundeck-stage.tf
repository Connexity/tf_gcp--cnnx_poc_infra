resource "google_compute_instance" "rundeck-stage" {
  name = "rundeckstage001"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  tags = ["allow-ingress", "allow-gce-usc1-stage", "allow-onprem"]

  boot_disk {
    size        = "50"
    source      = "projects/cnnx-infra-osimages/global/images/cnnx-ubuntu-2004-focal-v20210413"
  }

  labels = {
    app   = "rundeck"
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

