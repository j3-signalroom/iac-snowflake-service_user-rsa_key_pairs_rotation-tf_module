# Create the Public RSA key pairs, Account Identifier, and User secrets in AWS Secrets Manager
# And, initially store placeholder values in the secrets, which will later be filled in by the
# Lambda function
resource "aws_secretsmanager_secret" "public_keys" {
    name = var.secret_insert == "" ? "/snowflake_resource" : "/snowflake_resource/${var.secret_insert}"
}

resource "aws_secretsmanager_secret_version" "public_keys" {
    secret_id     = aws_secretsmanager_secret.public_keys.id
    secret_string = jsonencode({"account": "<ACCOUNT>",
                                "user": "<USER>",
                                "rsa_public_key_1": "<RSA_PUBLIC_KEY_1>",
                                "rsa_public_key_2": "<RSA_PUBLIC_KEY_2>"})
}

# Create the Private RSA key pair 1 secret in AWS Secrets Manager.  And, initially store a placeholder
# value in the secret, which will later be filled in by the Lambda function
resource "aws_secretsmanager_secret" "private_key_1" {
    name = var.secret_insert == "" ? "/snowflake_resource/rsa_private_key_pem_1" : "/snowflake_resource/${var.secret_insert}/rsa_private_key_pem_1"
}

resource "aws_secretsmanager_secret_version" "private_key_1" {
    secret_id     = aws_secretsmanager_secret.private_key_1.id
    secret_string = "<RSA_PRIVATE_KEY_1>"
}

# Create the Private RSA key pair 2 secret in AWS Secrets Manager.  And, initially store a placeholder
# value in the secret, which will later be filled in by the Lambda function
resource "aws_secretsmanager_secret" "private_key_2" {
    name = var.secret_insert == "" ? "/snowflake_resource/rsa_private_key_pem_2" : "/snowflake_resource/${var.secret_insert}/rsa_private_key_pem_2"
}

resource "aws_secretsmanager_secret_version" "private_key_2" {
    secret_id     = aws_secretsmanager_secret.private_key_2.id
    secret_string = "<RSA_PRIVATE_KEY_2>"
}
