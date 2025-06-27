terraform {
  backend "http" {
  }
}

variable "gcp_project" {
  default     = ""
  description = "TF_VAR_gcp_project env variable"
  type        = string
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
  gcp_project = "${var.gcp_project}"
}

module "sysops" {
  source = "./sysops"
  gcp_project = "${var.gcp_project}"
}
