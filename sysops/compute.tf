variable "it_node_count" {
  default = "3"
 }

resource "google_compute_instance_template" "cnnx-ubuntu-20-e2-highmem-4-50-150-ssd-usc1" {
  name          = "cnnx-ubuntu-20-e2-highmem-50-150-ssd-usc1"
  description   = "template for solr it 150 ssd attached"

  labels  = {
    owner = "platform"
    app = "solr-it"
  }

  machine_type    = "e2-highmem-4"

  disk {
    source_image      = "projects/cnnx-infra-osimages/global/images/family/cnnx-ubuntu-2004-lts"
    auto_delete       = true
    boot              = true
  }

  metadata = {
    env = "staging"
  }

  metadata_startup_script = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"

  network_interface {
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-infra-admin-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }
   
}

resource "google_compute_disk" "test-it-stage" {
    count   = "${var.it_node_count}"
    name    = "test-it-stage${count.index}-1"
    type    = "pd-standard"
    zone    = "us-central1-c"
    size    = "5"
}

resource "google_compute_instance" "test-it-stage" {
    count = "${var.node_count}"
    name = "test-it-stage${count.index}-1"
    machine_type = "e2-highmem-4"
    zone = "us-central1-c"

    boot_disk {
    initialize_params {
    image = "projects/cnnx-infra-osimages/global/images/family/cnnx-ubuntu-2004-lts"
    }
   }
    attached_disk {
        source      = "${element(google_compute_disk.test-it-stage.*.self_link, count.index)}"
        device_name = "${element(google_compute_disk.test-it-stage.*.name, count.index)}"
   }

    network_interface {
      subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-infra-admin-gce-1"
      subnetwork_project = "cnnx-infra-networking"
    } 

}

