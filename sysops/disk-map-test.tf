variable "map_persistent-disk" {
  description = "A way to create a persistent disk in different zones and sizes"
  type        = map(list(string))
  default = {
    "mapped_disk01" = [ "pd-standard", "us-central1-a", "50" ],
    "mapped_disk02" = [ "pd-ssd", "us-central1-c", "100" ],
    "mapped_disk03" = [ "pd-ssd", "us-central1-f", "120" ],
  }
}

resource "google_compute_disk" "cnnx-poc-infra_persistent-disks" {
  project = "${var.gcp_project}"
  for_each = var.map_persistent-disk
  name     = each.key
  type     = each.value[0]
  zone     = each.value[1]
  size     = each.value[2]
  labels   = {
    app = "sysops"
    owner = "platform"
  }
}
