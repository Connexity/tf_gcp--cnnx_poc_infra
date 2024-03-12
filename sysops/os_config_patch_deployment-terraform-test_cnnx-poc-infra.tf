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

  recurring_schedule {
    time_zone {
      id = "America/Los_Angeles"
    }
    time_of_day {
      hours = 10
    }
    monthly {
      week_day_of_month {
        week_ordinal = 1
        day_of_week = "MONDAY"
      }
    }
  }
}
