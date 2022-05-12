
variable "cloudflare_email" {
  description = "Cloudflare account"
  type        = string
}

variable "cloudflare_api_key" {
  description = "Cloudflare API key"
  type        = string
}

variable "site_domain" {
  type = string
}

variable "server_subdomain" {
  type = string
}

variable "compartment_id" {
  description = "OCID from your tenancy page"
  type        = string
}

variable "region" {
  description = "region where you have OCI tenancy"
  type        = string
  default     = "eu-amsterdam-1"
}

variable "availability_domain" {
  description = "region where you have OCI tenancy"
  type        = string
  default     = "cZiv:eu-amsterdam-1-AD-1"
}

variable "subnet_id" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "instance_cpu_count" {
  type = string
}

variable "instance_memory_gb" {
  type = string
}

variable "instance_boot_vol_gb" {
  type = string
}

variable "instance_image_id" {
  description = "Which image to use"
  type        = string
}

variable "volume_display_name" {
  type = string
}

variable "volume_vpus_per_gb" {
  type = string
}

variable "volume_size_in_gbs" {
  type = string
}

variable "volume_attachment_attachment_type" {
  type = string
}
