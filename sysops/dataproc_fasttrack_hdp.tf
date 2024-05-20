resource "google_dataproc_cluster" "test-fasttrack-hdp" {
  name     = "test-fasttrack-hdp"
  region   = "us-central1"
  graceful_decommission_timeout = "120s"
  labels = {
    owner = "marketplace"
    app = "fasttrack"
  }

  cluster_config {
    staging_bucket = "fasttrack-hpd-staging-cnnx-poc-infra"

    master_config {
      num_instances = 1
      machine_type  = "n2-standard-8"
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = 100
      }
    }

    worker_config {
      num_instances    = 2
      machine_type     = "n2-standard-8"
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = 100
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    # Override or set some custom properties
    software_config {
      image_version = "1.3.95-debian10"
    }

    gce_cluster_config {
      zone = "us-central1-f"
      tags = ["allow-gce-usc1-stage", "allow-onprem"]
      subnetwork = "projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-usc1-stage-gce-1"
      service_account = "fasttrack-hdp@cnnx-poc-infra.iam.gserviceaccount.com"
      internal_ip_only = true
      shielded_instance_config{
        enable_secure_boot          = true
        enable_vtpm                 = true
        enable_integrity_monitoring = true
      }
    }

  #enable Component Gateway
  endpoint_config {
    enable_http_port_access = "true"
    }
  }
}
