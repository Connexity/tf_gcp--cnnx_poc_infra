resource "google_compute_instance" "groups-validation" {
  name = "groups-validation"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  tags = ["allow-ingress", "allow-gce-usc1-stage", "allow-onprem"]

  boot_disk {
    initialize_params {
      size        = "10"
      image      = "projects/cnnx-infra-osimages/global/images/cnnx-ubuntu-2004-focal-v20210413"
    }
  }

  labels = {
    app   = "groupsvalidation"
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

### Deactivated 4.07.2024 ELI
#  resource_policies = [
#    google_compute_resource_policy.quarterly_schedule.id
#  ]
  
}

resource "google_compute_resource_policy" "quarterly_schedule" {
  name   = "quarterly-vm-start-stop"
  region = "us-central1"
  description = "Start and stop instances"
  instance_schedule_policy {
    vm_start_schedule {
      schedule = "0 0 1 1,4,7,10 *"
    }
    vm_stop_schedule {
      schedule = "30 0 1 1,4,7,10 *"
    }
    time_zone = "US/Central"
  }
}

