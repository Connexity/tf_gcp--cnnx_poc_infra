variable "it_node_count" {

  default = "5"
 }

resource "google_compute_disk" "test-it-stage" {
    count   = "${var.it_node_count}"
    name    = "${format("test-it-stage%03d-1", count.index + 1)}"
    type    = "pd-ssd"
    zone    = "us-central1-c"
    size    = "150"
    labels = {
      app = "test"
      owner = "sysops"
    }
}

resource "google_compute_instance" "test-it-stage" {
    count = "${var.it_node_count}"
    name = "${format("test-it-stage%03d", count.index + 1)}"
    machine_type = "e2-highmem-4"
    zone = "us-central1-a"

    labels = {
      app   = "test"
      owner = "sysops"
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

    tags = ["allow-gce-lb", "allow-gce-usc1-stage", "allow-onprem"]

    boot_disk {
      device_name = "${format("test-it-stage%03d", count.index + 1)}"
      initialize_params {
      image = "projects/cnnx-infra-osimages/global/images/family/cnnx-ubuntu-2004-lts" 
      }
    }
    
    attached_disk {
        source      = "${element(google_compute_disk.test-it-stage.*.self_link, count.index)}"
    }
   
    network_interface {
      subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
      subnetwork_project = "cnnx-infra-networking"
    }

    metadata = {
      env = "staging"
    }

    metadata_startup_script = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"

}
