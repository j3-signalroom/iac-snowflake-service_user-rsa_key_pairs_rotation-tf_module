output "active_rsa_public_key_number" {
    value       = local.latest_rsa_public_key_number
    description = "The current active RSA public key number."
}

output "rsa_snowflake_public_key_pem_1" {
    value       = local.key_pairs["snowflake_rsa_public_key_pem_1"]
    description = "The generated Snowflake RSA public key PEM 1."
}

output "rsa_snowflake_public_key_pem_2" {
    value       = local.key_pairs["snowflake_rsa_public_key_pem_2"]
    description = "The generated Snowflake RSA public key PEM 2."
}

output "rsa_jwt_1" {
    value       = local.key_pairs["rsa_jwt_1"]
    description = "The generated RSA JWT 1."
}

output "rsa_jwt_2" {
    value       = local.key_pairs["rsa_jwt_2"]
    description = "The generated RSA JWT 2."
}
