variable "map_import-disk" {
  description = "A way to create a persistent disk in different zones and sizes"
  type        = map(list(string))
  default = {
    "mapped-disk04" = [ "pd-standard", "us-central1-a", "50" ],
    "mapped-disk05" = [ "pd-ssd", "us-central1-c", "100" ],
    "mapped-disk06" = [ "pd-ssd", "us-central1-f", "50" ],
  }
}

import {
  for_each = var.map_import-disk
  id = "projects/cnnx-poc-infra/zones/${each.value[1]}/disks/${each.key}"
  to = module.sysops.google_compute_disk.cnnx-poc-infra_persistent-disks["${each.key}"]
}
