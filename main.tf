terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.13.0"
    }
  }
}

provider "cloudflare" {
  email     = var.cloudflare_email
  api_token = var.cloudflare_api_key
}

provider "oci" {
  region              = var.region
  auth                = "SecurityToken"
  config_file_profile = "mapserver"
}

resource "oci_core_volume" "mapserver_volume" {
  compartment_id       = var.compartment_id
  display_name         = var.volume_display_name
  size_in_gbs          = var.volume_size_in_gbs
  is_auto_tune_enabled = true
  vpus_per_gb          = var.volume_vpus_per_gb
  availability_domain  = var.availability_domain
}

resource "oci_core_instance" "mapserver" {
  agent_config {
    is_management_disabled = "false"
    is_monitoring_disabled = "false"
    plugins_config {
      desired_state = "DISABLED"
      name          = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Bastion"
    }
  }
  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  create_vnic_details {
    assign_private_dns_record = "true"
    assign_public_ip          = "true"
    subnet_id                 = var.subnet_id
  }

  display_name = var.instance_name

  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }
  metadata = {
    "user_data"           = "I2Nsb3VkLWNvbmZpZwogCnBhY2thZ2VzOgogLSBjdXJsCiAtIHdnZXQKIC0gYnlvYnUKIC0gc3VkbwogLSBhcHQtdHJhbnNwb3J0LWh0dHBzCiAtIGdudXBnCiAtIHB5dGhvbjMKIC0gaXBlcmYzCiAtIHVmdwogLSBpb3RvcAogLSBvcGVuamRrLTE3LWpyZS1oZWFkbGVzcyAKCnBhY2thZ2VfdXBncmFkZTogdHJ1ZQoKcnVuY21kOgogIC0gcHZjcmVhdGUgL2Rldi9zZGIKICAtIHZnY3JlYXRlIG1hcGx2IC9kZXYvc2RiCiAgLSBsdmNyZWF0ZSAtbCArMTAwJUZSRUUgLW4gc3RvcmUgbWFwbHYgCiAgLSBta2ZzLmV4dDQgL2Rldi9tYXBwZXIvbWFwbHYtc3RvcmUKICAtIG1vdW50IC9kZXYvbWFwcGVyL21hcGx2LXN0b3JlIC9tbnQKICAtIG1rZGlyIC9tbnQvZGF0YQogIC0gY2hvd24gLVIgdWJ1bnR1OnVidW50dSAvbW50L2RhdGEKCnN3YXA6CiAgZmlsZW5hbWU6IC9zd2FwLmltZwogIHNpemU6ICJhdXRvIiAjIG9yIHNpemUgaW4gYnl0ZXMKICBtYXhzaXplOiAxMjAwMDAwMDAwMCAgICMgc2l6ZSBpbiBieXRlcw=="
    "ssh_authorized_keys" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOhgHSf8ruSnUzu+tpFbFR3W9cA6p3144LQVG498IZFW\r\nssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdYzj/cIJ//CR6pwSZJ4i3MFipSOgtxIIhoXCCFLO6+"
  }

  shape = "VM.Standard.A1.Flex"

  shape_config {
    memory_in_gbs = var.instance_memory_gb
    ocpus         = var.instance_cpu_count
  }
  source_details {
    source_id   = var.instance_image_id
    source_type = "image"
  }
}

resource "oci_core_volume_attachment" "mapserver_volume_attachment" {
  #Required
  attachment_type = var.volume_attachment_attachment_type
  instance_id     = oci_core_instance.mapserver.id
  volume_id       = oci_core_volume.mapserver_volume.id
}

data "cloudflare_zones" "domain" {
  filter {
    name = var.site_domain
  }
}

resource "cloudflare_record" "server_record" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.server_subdomain
  value   = oci_core_instance.mapserver.*.public_ip[0]
  type    = "A"

  ttl             = 1
  proxied         = false
  allow_overwrite = true

  depends_on = [
    oci_core_instance.mapserver,
  ]
}
