resource "google_compute_instance" "instance_logdumpprod001" {
  name = "logdumpprod001"
  machine_type = "e2-micro"
  project = "${var.gcp_project}"
  zone = "us-central1-f"

  tags = [
    "allow-onprem",
    "allow-gce-usc1-prod",
    "allow-gce-lb"
  ]

  boot_disk {
    initialize_params {
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20220905"
      labels = {
        owner = "marketplace"
        app = "logdump"
      }
    }
  }

  labels = {
    owner = "marketplace"
    app = "logdump"
  }

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  service_account {
    email  = "logdump@cnnx-stage-tracking.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"
}

resource "google_compute_instance" "instance_logdumpprod002" {
  name = "logdumpprod002"
  machine_type = "e2-micro"
  project = "${var.gcp_project}"
  zone = "us-central1-b"

  tags = [
    "allow-onprem",
    "allow-gce-usc1-prod",
    "allow-gce-lb"
  ]

  boot_disk {
    initialize_params {
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20220905"
      labels = {
        owner = "marketplace"
        app = "logdump"
      }
    }
  }

  labels = {
    owner = "marketplace"
    app = "logdump"
  }

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  service_account {
    email  = "logdump@cnnx-stage-tracking.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_secure_boot          = "true"
    enable_integrity_monitoring = "true"
    enable_vtpm                 = "true"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"
}

data "google_iam_policy" "logdumpprod_cnnx-stage-tracking_iam_binding" {
  binding {
    role = "roles/compute.osLogin"
    members = [
      "serviceAccount:logdump@cnnx-stage-tracking.iam.gserviceaccount.com",
    ]
  }
  binding {
    role = "roles/compute.instanceAdmin.v1"
    members = [
      "group:cnnx-marketplace-lead@skimlinks.co.uk",
    ]
  }
}

resource "google_compute_instance_iam_policy" "logdumpprod001_cnnx-prod-tracking_iam_policy" {
  project = google_compute_instance.instance_logdumpprod001.project
  zone = google_compute_instance.instance_logdumpprod001.zone
  instance_name = google_compute_instance.instance_logdumpprod001.name
  policy_data = data.google_iam_policy.logdumpprod_cnnx-stage-tracking_iam_binding.policy_data
}

resource "google_compute_instance_iam_policy" "logdumpprod002_cnnx-prod-tracking_iam_policy" {
  project = google_compute_instance.instance_logdumpprod002.project
  zone = google_compute_instance.instance_logdumpprod002.zone
  instance_name = google_compute_instance.instance_logdumpprod002.name
  policy_data = data.google_iam_policy.logdumpprod_cnnx-stage-tracking_iam_binding.policy_data
}
