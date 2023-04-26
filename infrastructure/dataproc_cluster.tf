resource "google_dataproc_cluster" "dataproc_cluster-dataproc-test-cluster-gce" {
  name     = "dataproc-test-cluster-gce"
  region   = "us-central1"
  graceful_decommission_timeout = "120s"
  labels = {
    owner = "infrastructure"
    app = "dataproc-test"
  }

  cluster_config {
    staging_bucket = "dataproc-test-bucket"

    master_config {
      num_instances = 1
      machine_type  = "e2-micro"
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 10
      }
    }

    worker_config {
      num_instances    = 2
      machine_type     = "e2-micro"
      disk_config {
        boot_disk_size_gb = 10
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }
  }
}

data "google_iam_policy" "cnnx-poc-infra_dataproc-test-cluster-gce_iam_binding" {
  binding {
    role = "roles/dataproc.worker"
    members = [
      "serviceAccount:dataproc-test@cnnx-poc-infra.iam.gserviceaccount.com",
    ]
  }
}

resource "google_dataproc_cluster_iam_policy" "cnnx-poc-infra_dataproc-test-cluster-gce_iam_policy" {
  project     = "${var.gcp_project}"
  region      = google_dataproc_cluster.dataproc_cluster-dataproc-test-cluster-gce.region
  cluster     = google_dataproc_cluster.dataproc_cluster-dataproc-test-cluster-gce.name
  policy_data = data.google_iam_policy.cnnx-poc-infra_dataproc-test-cluster-gce_iam_binding.policy_data
}
