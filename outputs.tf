output "active_key_number" {
    value       = local.latest_rsa_public_key_number
    description = "The current active RSA public key number."
}

output "active_rsa_public_key" {
    value       = count.index == 1 ? jsondecode(aws_lambda_invocation.lambda_function.function_name)["rsa_public_key_1"] : jsondecode(aws_lambda_invocation.lambda_function.function_name)["rsa_public_key_2"]
    description = "The currently active RSA public key."
}
