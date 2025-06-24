resource "google_compute_instance" "instance_rt-backup-stage001" {
  name = "rt-backup-prod001"
  machine_type = "n4-standard-2"
  zone         = "us-central1-f"
  tags = ["allow-gce-usc1-infra" ,"allow-onprem", "allow-gce-usc1-prod", "allow-ingress", "allow-internal-workstation-endpoints-all-ports" ]
  project = "${var.gcp_project}"

  can_ip_forward      = "false"
  deletion_protection = "true"
  enable_display      = "false"

  boot_disk {
    initialize_params {
      image = "cnnx-infra-osimages/cnnx-ubuntu-2204-jammy-v20250112"
      size = 300
      provisioned_throughput = 240
      provisioned_iops = 15000
    }
    auto_delete = "true"
    device_name = "rt-backup-stage001"
    mode        = "READ_WRITE"
  }

  labels = {
    app   = "rt-backup"
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
    email  = "rt-backup@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }
}

data "google_iam_policy" "rt-backup-stage001_instace_admin_iam_binding" {
  binding {
    role = "roles/compute.instanceAdmin.v1"
    members = [
      "serviceAccount:gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
    ]
  }
}

resource "google_compute_instance_iam_policy" "rt-backup-prod001_instace_admin_iam_policy" {
  project = google_compute_instance.instance_rt-backup-stage001.project
  zone = google_compute_instance.instance_rt-backup-stage001.zone
  instance_name = google_compute_instance.instance_rt-backup-stage001.name
  policy_data = data.google_iam_policy.rt-backup-stage001_instace_admin_iam_binding.policy_data
}
