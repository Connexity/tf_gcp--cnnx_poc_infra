resource "google_notebooks_instance" "vertex-ai-workbench--test-notebook-instance" {
  name = "test-notebook-instnace"
  location = "us-central1-a"
  machine_type = "n1-standard-1"

  vm_image {
    project      = "deeplearning-platform-release"
    image_family = "tf-latest-cpu"
  }

  service_account = "gce-sa@cnnx-poc-infra.iam.gserviceaccount.com"

  boot_disk_type = "PD_SSD"
  boot_disk_size_gb = 10

  no_public_ip = true
  no_proxy_access = true

  network = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc" 
  subnet = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"

  labels = {
    owner = "sysops"
    app = "vertex-test"
  }
}
