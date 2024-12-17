variable "map_persistent-disk" {
  description = "A way to create a persistent disk in different zones and sizes"
  type        = map(list(string))
  default = {
    "mapped-disk01" = [ "pd-standard", "us-central1-a", "50", "app1" ],
    "mapped-disk03" = [ "pd-ssd", "us-central1-f", "120", "app3" ],
    "mapped-disk04" = [ "pd-standard", "us-central1-a", "50", "app4" ],
    "mapped-disk05" = [ "pd-ssd", "us-central1-c", "100", "app5" ],
    "mapped-disk06" = [ "pd-ssd", "us-central1-f", "50", "app6" ],
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
    app = each.value[3]
    owner = "platform"
  }
}
