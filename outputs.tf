output "active_key_number" {
    value       = lookup(local.dates_and_count, local.sorted_dates[0])
    description = "The current active RSA public key number."
}

output "secrets_path" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["secrets_path"]
    description = "The secrets path."
}

output "rsa_public_key_1_pem" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["rsa_public_key_1_pem"]
    description = "The generated RSA Public Key 1 PEM."
}

output "rsa_public_key_2_pem" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["rsa_public_key_2_pem"]
    description = "The generated RSA Public Key 2 PEM."
}

output "snowflake_rsa_public_key_1_pem" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["snowflake_rsa_public_key_1_pem"]
    description = "The generated Snowflake RSA Public Key 1 PEM."
}

output "snowflake_rsa_public_key_2_pem" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["snowflake_rsa_public_key_2_pem"]
    description = "The generated Snowflake RSA Public Key 2 PEM."
}

output "snowflake_rsa_private_key_1_pem" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["snowflake_rsa_private_key_1_pem"]
    description = "The generated Snowflake RSA Private Key 1 PEM."
}

output "snowflake_rsa_private_key_2_pem" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["snowflake_rsa_private_key_2_pem"]
    description = "The generated Snowflake RSA Private Key 2 PEM."
}

output "snowflake_rsa_jwt_1" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["snowflake_rsa_jwt_1"]
    description = "The generated Snowflake RSA JWT 1."
    sensitive   = true
}

output "snowflake_rsa_jwt_2" {
    value       = jsondecode(aws_lambda_invocation.lambda_function.result)["data"]["snowflake_rsa_jwt_2"]
    description = "The generated Snowflake RSA JWT 2."
    sensitive   = true
}
