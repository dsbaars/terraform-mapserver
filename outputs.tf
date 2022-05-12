# Output the private and public IPs of the instance
output "InstancePrivateIPs" {
  value = ["${oci_core_instance.mapserver.*.private_ip}"]
}

output "InstancePublicIPs" {
  value = ["${oci_core_instance.mapserver.*.public_ip}"]
}

# Output the boot volume IDs of the instance
output "BootVolumeIDs" {
  value = ["${oci_core_instance.mapserver.*.boot_volume_id}"]
}

# Output the boot volume IDs of the instance
output "BlockVolumeID" {
  value = oci_core_instance.mapserver.id
}