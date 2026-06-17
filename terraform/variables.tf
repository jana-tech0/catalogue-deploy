variable "project_name" {
  default = "roboshop"
}

variable "env" {
  default = "dev"
}

variable "app_version" {        # ← rename from "version" to "app_version"
  description = "App version to deploy"
  type        = string
}

variable "common_tags" {
  default = {
    Project = "roboshop"
    Component = "catalogue"
    Environment = "DEV"
    Terraform = "true"
  }
}
