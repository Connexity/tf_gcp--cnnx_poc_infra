locals {
  test_solr_cluster_instance_count = 2
  test_solr_cluster_name_prefix = "solr-test-stage"
  test_solr_cluster_zone = "us-central1-c"
  test_solr_cluster_machine_type = "n4-highmem-8"
  test_solr_cluster_labels = {
    owner = "sysops"
    app = "solr-test"
  }
  test_solr_cluster_email = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"
  test_solr_cluster_tags = ["allow-onprem", "allow-gce-usc1-stage", "allow-gce-lb" ]
  test_solr_cluster_umig_name = "lb-umig-usc1g-c-solr-test-stage-tf"
}


resource "google_compute_instance" "Instance_solr-test-stage-instances" {
  count = local.test_solr_cluster_instance_count

  project = "${var.gcp_project}"
  name = "${format("${local.test_solr_cluster_name_prefix}%03s", count.index+101)}"
  labels = local.test_solr_cluster_labels
  machine_type = local.test_solr_cluster_machine_type
  tags = local.test_solr_cluster_tags
  zone = local.test_solr_cluster_zone

  boot_disk {
    initialize_params {
      image = "cnnx-infra-osimages/cnnx-ubuntu-2004-focal-v20230715"
      size = 50
      provisioned_iops = 15000
      provisioned_throughput = 515
      labels = local.test_solr_cluster_labels
    }
    auto_delete = "true"
    device_name = "${format("${local.test_solr_cluster_name_prefix}%03s", count.index+101)}"
    mode        = "READ_WRITE"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"

  metadata = {
    env            = "staging"
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
    email  = local.test_solr_cluster_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }
}

resource "google_compute_instance_group" "lb_umig_usc1g_c_solr_test_stage_tf" {
  name = local.test_solr_cluster_umig_name
  zone = local.test_solr_cluster_zone
  project   = "${var.gcp_project}"
  instances = [ for x in google_compute_instance.Instance_solr-test-stage-instances: x.self_link ]
  named_port {
    name = "tcp9100"
    port = "9100"
  }
}
