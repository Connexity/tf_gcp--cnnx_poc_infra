terraform {
  backend "http" {
  }
}

variable "gcp_project" {
  type = string
}

provider "google" {
  project = "${var.gcp_project}"
}

module "project_globals" {
  source = "./project_globals"
  gcp_project = "${var.gcp_project}"
}

module "infrastructure" {
  source = "./infrastructure"
}
