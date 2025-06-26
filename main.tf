terraform {
  backend "http" {
  }
}

variable "TFC_WORKSPACE_NAME" {
  default     = ""
  description = "Terraform Cloud workspace name"
  type        = string
}

variable "gcp_project" {
  type = string
  default = var.TFC_WORKSPACE_NAME
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
