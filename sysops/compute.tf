### solr-us-test061 ###

resource "google_compute_disk" "persistent-disk_solr-us-test061-1" {
  name  = "solr-us-test061-1"
  type  = "pd-ssd"
  zone  = "us-central1-a"
  size  = 250
  project = "${var.gcp_project}"
  labels = {
    owner = "platform"
    app = "solr-us"
  }
}

resource "google_compute_instance" "Instance_solr-us-tes061" {
  attached_disk {
    device_name = "persistent-disk-1"
    mode        = "READ_WRITE"
    source      = "https://www.googleapis.com/compute/v1/projects/cnnx-poc-infra/zones/us-central1-a/disks/solr-us-test061-1"
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
    device_name = "solr-us-test061"
    mode        = "READ_WRITE"
    source      = "https://www.googleapis.com/compute/v1/projects/cnnx-prod-search/zones/us-central1-a/disks/solr-us-test061"
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

  name = "solr-us-test061"

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

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }

  tags = ["allow-onprem", "allow-gce-lb", "allow-gce-usc1-stage"]
  zone = "us-central1-a"
}


### solr-gb-test005 ###

resource "google_compute_disk" "persistent-disk_solr-gb-test005-1" {
  name  = "solr-gb-test005-1"
  type  = "pd-ssd"
  zone  = "us-central1-a"
  size  = 200
  project = "${var.gcp_project}"
  labels = {
    owner = "platform"
    app = "catalog-gb"
  }
}

resource "google_compute_instance" "Instance_solr-gb-test005" {
  attached_disk {
    device_name = "persistent-disk-1"
    mode        = "READ_WRITE"
    source      = "https://www.googleapis.com/compute/v1/projects/cnnx-poc-infra/zones/us-central1-a/disks/solr-gb-test005-1"
  }

  boot_disk {
    initialize_params {
      size = 50
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20220905"
      labels = {
        owner = "platform"
        app = "catalog-gb"
      }
    }
    auto_delete = "true"
    device_name = "solr-gb-test005"
    mode        = "READ_WRITE"
    source      = "https://www.googleapis.com/compute/v1/projects/cnnx-poc-infra/zones/us-central1-a/disks/solr-gb-test005"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"

  labels = {
    app   = "catalog-gb"
    owner = "platform"
  }

  machine_type = "n2-standard-2"

  metadata = {
    env            = "stage"
    startup-script = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"
  }

  name = "solr-gb-test005"

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

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }

  tags = ["allow-onprem", "allow-gce-lb", "allow-gce-usc1-stage"]
  zone = "us-central1-a"
}
