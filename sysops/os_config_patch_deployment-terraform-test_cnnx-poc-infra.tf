resource "google_os_config_patch_deployment" "patch_deployment-terraform-test_cnnx-poc-infra" {
  patch_deployment_id = "terraform-test-cnnx-poc-infra"

  instance_filter {
    instance_name_prefixes = [ "os-manage" ]
    all = false
    zones = ["us-central1-a","us-central1-b","us-central1-c","us-central1-f"]
    group_labels {
      labels = {
        app = "osmanagementtest"
      }
    }
  }

  patch_config {
    apt {
      type = "UPGRADE"
    }
  }

  rollout {
    mode = "ZONE_BY_ZONE"
    disruption_budget {
      fixed = 1
    }
  }

  one_time_schedule {
    execute_time = "2999-10-10T10:10:10.045123456Z"
  }
}
