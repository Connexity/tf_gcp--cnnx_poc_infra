resource "google_redis_instance" "redis--test_service_cnnx-poc-infra" {
  name           = "test-service-redis001"
  tier           = "BASIC"
  memory_size_gb = 1

  location_id             = "us-central1-a"

  labels = {
    app = "test"
    owner = "sysops"
  }
}
