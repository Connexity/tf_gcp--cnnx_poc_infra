resource "google_compute_resource_policy" "scheduke--eu_workingtime_test1" {
  name   = "eu-workingtime-test1"
  region = "us-central1"
  description = "Start and stop instances"
  instance_schedule_policy {
    vm_start_schedule {
      schedule = "0 9 * * 1-5"
    }
    vm_stop_schedule {
      schedule = "30 10 * * 1-5"
    }
    time_zone = "Europe/Berlin"
  }
}
