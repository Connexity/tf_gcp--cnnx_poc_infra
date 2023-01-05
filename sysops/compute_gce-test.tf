resource "google_compute_instance" "instance_gcemultidiskteststage001" {
  name = "gcemultidiskteststage001"
  machine_type = "n2-standard-4"
  project = "${var.gcp_project}"
  zone = "us-central1-c"

  tags = [
    "allow-onprem",
    "allow-gce-usc1-stage"
  ]

  boot_disk {
    initialize_params {
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20220905"
      type = "pd-balanced"
      labels = {
        owner = "sysops"
        app = "test"
      }
    }
  }

  labels = {
    owner = "sysops"
    app = "test"
  }

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  service_account {
    email  = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    env                = "staging"
    startup-script-url = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"
  }

  shielded_instance_config {
    enable_secure_boot = "true"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"
}

resource "google_compute_disk" "gcedisk_gcemultidisktest-shared-disk" {
  provider = google-beta
  project = "${var.gcp_project}"
  name  = "gcemultidisktest-shared-disk"
  type  = "pd-ssd"
  zone  = "us-central1-c"
  labels = {
    owner = "sysops"
    app  =  "test"
  }
  size = 100
  physical_block_size_bytes = 4096
  multi_writer = true
  depends_on = [google_compute_instance.instance_gcemultidiskteststage001]
}

resource "google_compute_attached_disk" "attach_disk_gcemultidiskteststage001-shared-disk" {
  project = "${var.gcp_project}"
  disk     = google_compute_disk.gcedisk_gcemultidisktest-shared-disk.id
  instance = google_compute_instance.instance_gcemultidiskteststage001.id
  zone = "us-central1-c"
  mode = "READ_WRITE"
  device_name = "persistent-disk-1"
  depends_on = [google_compute_disk.gcedisk_gcemultidisktest-shared-disk]
}
