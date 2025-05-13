variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "region" {
  description = "GCP region."
  type        = string
}

variable "zone" {
  description = "GCP zone."
  type        = string
}

variable "service_account_id" {
  description = "Service account ID (without domain)."
  type        = string
}

variable "service_account_display_name" {
  description = "Display name for the service account."
  type        = string
  default     = "Service Account"
}

variable "vpc_network_name" {
  description = "Name of the VPC network."
  type        = string
}

variable "subnetwork_name" {
  description = "Name of the subnetwork."
  type        = string
}

variable "subnetwork_cidr" {
  description = "CIDR range for the subnetwork."
  type        = string
}

variable "static_ip_name" {
  description = "Name for the external static IP resource."
  type        = string
}

variable "instance_name" {
  description = "Name of the compute instance."
  type        = string
}

variable "machine_type" {
  description = "Machine type for the compute instance."
  type        = string
}

variable "accelerator_type" {
  description = "GPU accelerator type, e.g. nvidia-l4."
  type        = string
  default     = "nvidia-l4"
}

variable "accelerator_count" {
  description = "Number of GPU accelerators."
  type        = number
  default     = 1
}

variable "image" {
  description = "Boot-disk image, e.g. ubuntu-os-cloud/ubuntu-2404-lts."
  type        = string
}

variable "disk_size" {
  description = "Boot-disk size in GB."
  type        = number
  default     = 150
}

variable "ssh_public_key" {
  description = "SSH public key in the form 'username:ssh-ed25519 AAA…'."
  type        = string
}
