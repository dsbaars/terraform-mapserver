
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
  default = "dbtc.link"
}

variable "server_subdomain" {
  type = string
  default = "mapserver"
}

variable "compartment_id" {
  description = "OCID from your tenancy page"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaa3q26a3xlsb6kfyhxwxyjfqek4ofoa3es2t7yqazonhq6geual54q"
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
  default = "ocid1.subnet.oc1.eu-amsterdam-1.aaaaaaaahu6fverpcf72rityxpnys65arct2ajjxmgyljngt5uxxv276slxq"
}

variable "instance_name" {
  type = string
  default = "mapserver"
}

variable "instance_cpu_count" {
  type = string
  default = 32
}

variable "instance_memory_gb" {
  type = string
  default = 384
}

variable "instance_boot_vol_gb" {
  type = string
  default = 90
}

variable "instance_image_id" {
  description = "Which image to use"
  type        = string
  default = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaacikrppi63aw3rbv4mu4kv3jaoifxh2pthh3sdajkyavaxkzxq6kq"
}

variable "volume_display_name" {
  type = string
  default = "mapserver-storage"
}

variable "volume_vpus_per_gb" {
  type = string
  default = 30
}

variable "volume_size_in_gbs" {
  type = string
  default = 640
}

variable "volume_attachment_attachment_type" {
  type = string
  default = "paravirtualized"
}
