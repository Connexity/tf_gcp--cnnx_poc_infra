resource "google_compute_disk" "persistent-disk_solr-us-test-disks" {
  count = 15

  name  = "${format("solr-us-test%03s-1", count.index+1)}"
  type  = "pd-ssd"
  zone  = "us-central1-a"
  size  = 250
  project = "${var.gcp_project}"
  labels = {
    owner = "platform"
    app = "solr-us"
  }
}


resource "google_compute_instance" "Instance_solr-us-test-instances" {
  count = 2

  attached_disk {
    device_name = "persistent-disk-1"
    mode        = "READ_WRITE"
    source      = "https://www.googleapis.com/compute/v1/projects/cnnx-poc-infra/zones/us-central1-a/disks/${format("solr-us-test%03s-1", count.index+1)}"
  }

  boot_disk {
    initialize_params {
      size = 50
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20220905"
      labels = {
        owner = "platform"
        app = "solr-us"
      }
    }
    auto_delete = "true"
    device_name = "${format("solr-us-test%03s", count.index+1)}"
    mode        = "READ_WRITE"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"

  labels = {
    app   = "solr-us"
    owner = "platform"
  }

  machine_type = "n2-standard-2"

  metadata = {
    env            = "stage"
    startup-script = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"
  }

  name = "${format("solr-us-test%03s", count.index+1)}"

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

  service_account {
    email  = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  scheduling {
    automatic_restart   = "true"
    min_node_cpus       = "0"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }

  tags = ["allow-onprem", "allow-gce-lb", "allow-gce-usc1-stage"]
  zone = "us-central1-a"
}
