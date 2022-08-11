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
    source_image      = "projects/cnnx-infra-os-images/global/images/family/cnnx-ubuntu-2004-lts"
    auto_delete       = true
    boot              = true
  }

  metadata {
    env    = "staging"
  }

  metadata_startup_script = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"
   
  network_interface {
    network = "default"
  }
}

resource "google_compute_disk" "test-node-1-index-disk-" {
    count   = "${var.it_node_count}"
    name    = "test-node-1-index-disk-${count.index}-data"
    type    = "pd-standard"
    zone    = "us-central1-c"
    size    = "5"
}
