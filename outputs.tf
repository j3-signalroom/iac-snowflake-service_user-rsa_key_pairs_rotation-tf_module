output "key_number" {
    value       = local.key_number
    description = "The current active RSA public key number."
}

output "snowflake_rsa_public_key_1_pem" {
    value       = local.key_pairs["snowflake_rsa_public_key_1_pem"]
    description = "The generated Snowflake RSA Public Key 1 PEM."
}

output "snowflake_rsa_public_key_2_pem" {
    value       = local.key_pairs["snowflake_rsa_public_key_2_pem"]
    description = "The generated Snowflake RSA Public Key 2 PEM."
}

output "rsa_jwt_1" {
    value       = local.key_pairs["rsa_jwt_1"]
    description = "The generated RSA JWT 1."
}

output "rsa_jwt_2" {
    value       = local.key_pairs["rsa_jwt_2"]
    description = "The generated RSA JWT 2."
}
