resource "google_compute_instance" "Instance_solr-test-stage-instances" {
  count = 2

  boot_disk {
    initialize_params {
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20230715"
      size = 250
      provisioned_iops = 15000
      provisioned_throughput = 515
      labels = {
        owner = "sysops"
        app = "solr-test"
      }
    }
    auto_delete = "true"
    device_name = "${format("solr-test-stage%03s", count.index+1)}"
    mode        = "READ_WRITE"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"

  labels = {
    app   = "solr-test"
    owner = "platform"
  }

  machine_type = "n4-highmem-8"

  metadata = {
    env            = "staging"
  }

  name = "${format("solr-test-stage%03s", count.index+1)}"

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    queue_count        = "0"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  project = "${var.gcp_project}"

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

  tags = ["allow-onprem", "allow-gce-usc1-stage", "allow-gce-lb"]
  zone = "us-central1-a"
}

