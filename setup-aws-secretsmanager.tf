# Create the Public RSA key pairs, Account Identifier, and User secrets in AWS Secrets Manager
# And, initially store placeholder values in the secrets, which will later be filled in by the
# Lambda function
resource "aws_secretsmanager_secret" "public_keys" {
    name = local.base_secrets_path
}

resource "aws_secretsmanager_secret_version" "public_keys" {
    secret_id     = aws_secretsmanager_secret.public_keys.id
    secret_string = jsonencode({"account_identifier": "<ACCOUNT_IDENTIFIER>",
                                "snowflake_user": "<SNOWFLAKE_USER>",
                                "rsa_public_key_1": "<RSA_PUBLIC_KEY_1>",
                                "rsa_public_key_2": "<RSA_PUBLIC_KEY_2>"})
}

# Create the Private RSA key pair 1 secret in AWS Secrets Manager.  And, initially store a placeholder
# value in the secret, which will later be filled in by the Lambda function
resource "aws_secretsmanager_secret" "private_key_pem_1" {
    name = "${local.base_secrets_path}/rsa_private_key_pem_1"
}

resource "aws_secretsmanager_secret_version" "private_key_pem_1" {
    secret_id     = aws_secretsmanager_secret.private_key_pem_1.id
    secret_string = "<RSA_PRIVATE_KEY_PEM_1>"
}

# Create the Private RSA key pair 2 secret in AWS Secrets Manager.  And, initially store a placeholder
# value in the secret, which will later be filled in by the Lambda function
resource "aws_secretsmanager_secret" "private_key_pem_2" {
    name = "${local.base_secrets_path}/rsa_private_key_pem_2"
}

resource "aws_secretsmanager_secret_version" "private_key_pem_2" {
    secret_id     = aws_secretsmanager_secret.private_key_pem_2.id
    secret_string = "<RSA_PRIVATE_KEY_PEM_2>"
}

# Create the Private RSA key pair 1 secret in AWS Secrets Manager.  And, initially store a placeholder
# value in the secret, which will later be filled in by the Lambda function
resource "aws_secretsmanager_secret" "private_key_1" {
    name = "${local.base_secrets_path}/rsa_private_key_1"
}

resource "aws_secretsmanager_secret_version" "private_key_1" {
    secret_id     = aws_secretsmanager_secret.private_key_1.id
    secret_string = "<RSA_PRIVATE_KEY_1>"
}

# Create the Private RSA key pair 2 secret in AWS Secrets Manager.  And, initially store a placeholder
# value in the secret, which will later be filled in by the Lambda function
resource "aws_secretsmanager_secret" "private_key_2" {
    name = "${local.base_secrets_path}/rsa_private_key_2"
}

resource "aws_secretsmanager_secret_version" "private_key_2" {
    secret_id     = aws_secretsmanager_secret.private_key_2.id
    secret_string = "<RSA_PRIVATE_KEY_2>"
}