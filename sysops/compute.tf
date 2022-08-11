locals {
  it_attached_disk_names = toset([
    "test-it-stage001-1",
    "test-it-stage003-1",
   ])
}

resource "google_compute_disk" "test-it-stage" {
    for_each = local.it_attached_disk_names
    name = each.value
    type    = "pd-ssd"
    zone    = "us-central1-a"
    size    = "150"
    labels = {
      app = "test"
      owner = "sysops"
    }
}

resource "google_compute_instance_template" "test-it-stage" {
    name = "test-it-stage"
    machine_type = "e2-highmem-4"

    labels = {
      app   = "test"
      owner = "sysops"
    }

    service_account {
      email  = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
      scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    }  

    shielded_instance_config {
      enable_integrity_monitoring = "true"
      enable_secure_boot          = "true"
      enable_vtpm                 = "true"
    }

    tags = ["allow-gce-lb", "allow-gce-usc1-stage", "allow-onprem"]

    disk {
      source_image      = "projects/cnnx-infra-osimages/global/images/family/cnnx-ubuntu-2004-lts"
      auto_delete       = true
      boot              = true
      }
    
    disk {
      disk_type = "pd-ssd"
      disk_size_gb = "150"
    }

    network_interface {
      subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
      subnetwork_project = "cnnx-infra-networking"
    }

    metadata = {
      env = "staging"
    }

    metadata_startup_script = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"

}

resource "google_compute_instance_from_template" "test-it-stage001" {
  name = "test-it-stage001"
  zone = "us-central1-a"

  source_instance_template = google_compute_instance_template.test-it-stage.id

}
