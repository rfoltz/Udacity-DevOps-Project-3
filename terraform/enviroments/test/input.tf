# Azure Secrets
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}


# Resource Vars
variable "location" {
  description = "Azure Region Location which call resources will reside"
  default     = "eastus"
  type        = string
}

variable "prefix" {
  description = "Prefix of all the resources"
  default     = "udacity-project3"
  type        = string
}