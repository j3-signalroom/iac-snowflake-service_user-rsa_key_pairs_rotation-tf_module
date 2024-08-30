output "active_rsa_key_pair" {
    value       = aws_lambda_invocation.lambda_function[local.latest_api_key]
    description = ""
}

output "all_rsa_key_pairs" {
    value       = [for d in local.sorted_dates : confluent_api_key.resouce_api_key[lookup(local.dates_and_count, d)]]
    description = "All RSA key pairs sorted by creation date.  With the current active RSA key pair being the 1st in the collection."
}