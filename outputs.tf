output "active_rsa_public_key_number" {
    value       = local.latest_rsa_public_key_number
    description = "The current active RSA public key number."
}

output "rsa_public_key_pem_1" {
    value       = local.response_body.rsa_public_key_pem_1
    description = "The generated RSA public key PEM 1."
}

output "rsa_public_key_pem_2" {
    value       = local.response_body.rsa_public_key_pem_2
    description = "The generated RSA public key PEM 2."
}

output "rsa_private_key_pem_1" {
    value       = local.response_body.rsa_private_key_pem_1
    description = "The generated RSA private key PEM 1."
}

output "rsa_private_key_pem_2" {
    value       = local.response_body.rsa_private_key_pem_2
    description = "The generated RSA private key PEM 2."
}

output "rsa_private_key_1" {
    value       = local.response_body.rsa_private_key_1
    description = "The generated RSA private key 1."
}

output "rsa_private_key_2" {
    value       = local.response_body.rsa_private_key_2
    description = "The generated RSA private key 2."
}

output "jwt_token_1" {
    value       = local.response_body.jwt_token_1
    description = "The generated JWT token 1."
}

output "jwt_token_2" {
    value       = local.response_body.jwt_token_2
    description = "The generated JWT token 2."
}

output "root_secrets_manager_path" {
    value       = local.response_body.root_secret_name
    description = "The path to the root secrets manager."
}
