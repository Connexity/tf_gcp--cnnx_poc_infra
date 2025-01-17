resource "google_compute_instance" "instance_ncftp-stage" {
  name = "ncftp-stage001"
  machine_type = "n4-standard-4"
  zone         = "us-central1-a"
  tags = ["allow-gce-usc1-infra", "allow-ingress", "allow-onprem", "allow-gce-usc1-stage" ]
  project = "${var.gcp_project}"

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"

  boot_disk {
    initialize_params {
      image = "cnnx-infra-osimages/cnnx-ubuntu-2204-jammy-v20250112"
      size = 50
    }
    auto_delete = "true"
    device_name = "ncftp-stage001"
    mode        = "READ_WRITE"
  }

  attached_disk {
    device_name = "persistent-disk-1"
    mode        = "READ_WRITE"
    source      = "https://www.googleapis.com/compute/v1/projects/cnnx-poc-infra/zones/us-central1-a/disks/ncftp-stage001-1"
  }

  labels = {
    app   = "ncftp"
    owner = "sysops"
  }

  metadata = {
    env                = "stage"
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
    email  = "ncftp-stage@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  
  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }
}

resource "google_compute_disk" "ncftp-stage001-1" {
  name = "ncftp-stage001-1"
  size = 100
  zone = "us-central1-a"
  type = "hyperdisk-balanced"
  labels = {
    app   = "ncftp"
    owner = "sysops"
  }
}
