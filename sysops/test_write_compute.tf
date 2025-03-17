variable "gce_instance_variables" {
  description = "Used to create unique instances with standard layout" 
  type = map(list(string))
  default = {
    rimcachepoc001 = ["us-central1-a", "e2-standard-2", "rimcachepoc-multi-write"]
    rimcachepoc002 = ["us-central1-c", "e2-standard-2", "rimcachepoc-multi-write"]
}

resource "google_compute_disk" "rimcachepoc_multi_write_compute_disk_1" {
  name  = "rimcachepoc-multi-write"
  type  = "pd-standard"
  zone  = "us-central1"
  labels = {
    app   = "rimcache"
    owner = "sysops"
  }
  multi_writer = true
}

resource "google_compute_instance" "rimcachepoc_compute_instance" {
  for_each = var.gce_instance_variables
  name = each.key
  machine_type = each.value[1]
  zone         = each.value[0]
  tags = ["allow-ingress", "allow-gce-usc1-stage", "allow-onprem"]
  allow_stopping_for_update = true
  project = "${var.gcp_project}"

  boot_disk {
    initialize_params {
      size        = "50"
      image      = "projects/cnnx-infra-osimages/global/images/cnnx-ubuntu-2204-jammy-v20240126"
    }
    labels = {
      app   = "rimcache"
      owner = "sysops"
    }
  }

  attached_disk {
    device_name = each.value[2]
    mode        = "READ_WRITE"
    source      = "https://www.googleapis.com/compute/v1/projects/${var.gcp_project}/zones/${each.value[0]}/disks/${each.value[2]}"
  }

  labels = {
    app   = "rimcache"
    owner = "sysops"
  }

  metadata = {
    env                = "staging"
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
