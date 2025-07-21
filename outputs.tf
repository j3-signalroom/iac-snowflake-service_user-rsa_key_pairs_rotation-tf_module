output "active_rsa_public_key_number" {
    value       = local.latest_rsa_public_key_number
    description = "The current active RSA public key number."
}

output "rsa_public_key_pem_1" {
    value       = local.key_pairs["rsa_public_key_pem_1"]
    description = "The generated RSA public key PEM 1."
}

output "rsa_public_key_pem_2" {
    value       = local.key_pairs["rsa_public_key_pem_2"]
    description = "The generated RSA public key PEM 2."
}

output "rsa_private_key_pem_1" {
    value       = local.key_pairs["rsa_private_key_pem_1"]
    description = "The generated RSA private key PEM 1."
}

output "rsa_private_key_pem_2" {
    value       = local.key_pairs["rsa_private_key_pem_2"]
    description = "The generated RSA private key PEM 2."
}

output "rsa_private_key_1" {
    value       = local.key_pairs["rsa_private_key_1"]
    description = "The generated RSA private key 1."
}

output "rsa_private_key_2" {
    value       = local.key_pairs["rsa_private_key_2"]
    description = "The generated RSA private key 2."
}

output "rsa_public_key_jwt_1" {
    value       = local.key_pairs["jwt_token_1"]
    description = "The generated RSA public key JWT token 1."
}

output "rsa_public_key_jwt_2" {
    value       = local.key_pairs["jwt_token_2"]
    description = "The generated RSA public key JWT token 2."
}

output "root_secrets_manager_secrets_path" {
    value       = local.key_pairs["root_secret_name"]
    description = "The secrets path to the root secrets manager."
}
