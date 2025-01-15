resource "google_compute_instance" "instance_sftpgo-stage" {
  name = "sftpgo-stage001"
  machine_type = "n4-standard-4"
  zone         = "us-central1-a"
  tags = ["allow-gce-usc1-infra", "allow-ingress", "allow-onprem", "allow-gce-usc1-stage" ]
  project = "${var.gcp_project}"

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"

  boot_disk {
    initialize_params {
      image      = "projects/cnnx-infra-osimages/global/images/cnnx-ubuntu-2204-jammy-v20241218"
      size = 50
      #commented out to test default iops and throughput
      #provisioned_iops = 10000
      #provisioned_throughput = 515
    }
    auto_delete = "false"
    device_name = "sftpgo-stage001"
    mode        = "READ_WRITE"
  }
    
  labels = {
    app   = "sftp"
    owner = "syseng"
  }

  metadata = {
    env                = "stage"
    startup-script-url = "http://gitlab.shopzilla.com/ansible/awx-boostrap-script/-/raw/master/awxprovision.py"
  }

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/global/networks/cnnx-infra-networking-core-vpc"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
    subnetwork_project = "cnnx-infra-networking"
  }

  service_account {
    email  = "sftpaccess@cnnx-poc-infra.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  
}
