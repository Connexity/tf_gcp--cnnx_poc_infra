resource "google_compute_instance" "Instance_schedule-test01" {
  boot_disk {
    auto_delete = "true"
    device_name = "schedule-test01"
    mode        = "READ_WRITE"
    initialize_params {
    image = "projects/cnnx-infra-osimages/global/images/family/cnnx-ubuntu-2004-lts"
      }
  }

  can_ip_forward = "false"

  confidential_instance_config {
    enable_confidential_compute = "false"
  }

  deletion_protection = "false"
  enable_display      = "false"

  labels = {
    env   = "staging"
    owner = "sysops"
  }

  machine_type = "e2-micro"

  metadata = {
    env                = "staging"
    startup-script-url = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"
  }

  name = "schedule-test01"

  network_interface {
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
}

  
  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = "true"
    min_node_cpus       = "0"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
  }

  service_account {
    email  = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "false"
    enable_vtpm                 = "true"
  }

  tags = ["allow-onprem", "allow-gce-usc1-stage"]
  zone = "us-central1-a"
}

