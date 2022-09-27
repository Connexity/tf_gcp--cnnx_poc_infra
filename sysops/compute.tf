resource "google_compute_instance" "instance_uimagetest-stage001" {

  name = "uimagetest-stage001"
  project = "${var.gcp_project}"
  machine_type = "e2-standard-2"
  tags = ["allow-onprem", "allow-gce-usc1-stage"]
  zone = "us-central1-a"
  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"

  labels = {
    app   = "test1"
    owner = "sysops"
  }

  boot_disk {
    auto_delete = "true"
    device_name = "uimagetest-stage001"
    mode        = "READ_WRITE"
    initialize_params {
      size = "20"
      type = "pd-standard"
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20220905"
    }
  }

  metadata = {
    env            = "staging"
    startup-script = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"
  }

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    queue_count        = "0"
    stack_type         = "IPV4_ONLY"
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
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }
}

resource "google_compute_instance" "instance_uimagetest-stage002" {

  name = "uimagetest-stage002"
  project = "${var.gcp_project}"
  machine_type = "e2-standard-2"
  tags = ["allow-onprem", "allow-gce-usc1-stage"]
  zone = "us-central1-a"
  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"

  labels = {
    app   = "test1"
    owner = "sysops"
  }

  boot_disk {
    auto_delete = "true"
    device_name = "uimagetest-stage002"
    mode        = "READ_WRITE"
    initialize_params {
      size = "10"
      type = "pd-standard"
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20210413"
    }
  }

  metadata = {
    env            = "staging"
    startup-script = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"
  }

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    queue_count        = "0"
    stack_type         = "IPV4_ONLY"
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
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }
}
