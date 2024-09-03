
# This controls each key's rotations
resource "time_rotating" "rsa_key_pair_rotations" {
    rotation_days = var.day_count*local.number_of_rsa_key_pairs_to_retain
    rfc3339 = timeadd(local.now, format("-%sh", local.hour_count))
}

# Store the retain RSA key pairs and the time when the rotation needs to accord.  In order, to 
# trigger a `replace_triggered_by` on the RSA key pair.  Refer to GitHub Issue for more info
# https://github.com/hashicorp/terraform-provider-time/issues/118
resource "time_static" "rsa_key_pair_rotations" {
    rfc3339 = time_rotating.rsa_key_pair_rotations.rfc3339
}
