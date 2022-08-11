variable "it_node_count" {
  default = "3"
 }

resource "google_compute_instance" "test-it-stage" {
    count = "${var.it_node_count}"
    name = "${format{test-it-stage%03d-1, ${count.index})}"
    machine_type = "e2-highmem-4"
    zone = "us-central1-c"

    tags = ["allow-gce-lb", "allow-gce-usc1-stage", "allow-onprem"]

    boot_disk {
    initialize_params {
    image = "projects/cnnx-infra-osimages/global/images/family/cnnx-ubuntu-2004-lts"
    }
   }

    network_interface {
      subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
      subnetwork_project = "cnnx-infra-networking"
    }

}
