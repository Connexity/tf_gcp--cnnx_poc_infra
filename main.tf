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
}

provider "google" {
  project = "${var.TFC_WORKSPACE_NAME}"
}

module "project_globals" {
  source = "./project_globals"
  gcp_project = "${var.TFC_WORKSPACE_NAME}"
}

module "infrastructure" {
  source = "./infrastructure"
  gcp_project = "${var.TFC_WORKSPACE_NAME}"
}

module "sysops" {
  source = "./sysops"
  gcp_project = "${var.TFC_WORKSPACE_NAME}"
}
