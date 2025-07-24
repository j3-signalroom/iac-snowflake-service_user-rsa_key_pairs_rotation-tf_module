output "key_number" {
    value       = lookup(local.dates_and_count, local.sorted_dates[0])
    description = "The current active RSA public key number."
}

output "snowflake_rsa_public_key_1_pem" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["snowflake_rsa_public_key_1_pem"]
    description = "The generated Snowflake RSA Public Key 1 PEM."
}

output "snowflake_rsa_public_key_2_pem" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["snowflake_rsa_public_key_2_pem"]
    description = "The generated Snowflake RSA Public Key 2 PEM."
}

output "rsa_jwt_1" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["rsa_jwt_1"]
    description = "The generated RSA JWT 1."
}

output "rsa_jwt_2" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["rsa_jwt_2"]
    description = "The generated RSA JWT 2."
}
