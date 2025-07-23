terraform {
    cloud {
        organization ="signalroom"

        workspaces {
            name = "iac-snowflake-user-rsa-key-pairs-rotation-tf-module-workspace"
        }
  }

  required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 6.4.0"
        }
    }
}

resource "aws_iam_role" "lambda_execution_role" {
  name = lower("${var.secret_insert}_role")

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name        = lower("${var.secret_insert}_policy")
  description = "IAM policy for the Snowflake RSA key pairs Generator Lambda execution role."
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Effect   = "Allow",
        Resource = local.ecr_repo_uri
      },
      {
        Action = "ecr:GetAuthorizationToken",
        Effect = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:PutSecretValue",
          "secretsmanager:CreateSecret",
          "secretsmanager:UpdateSecret"
        ],
        Effect = "Allow",
        Resource = [
          aws_secretsmanager_secret.public_keys.arn,
          aws_secretsmanager_secret.private_key_pem_1.arn,
          aws_secretsmanager_secret.private_key_pem_2.arn,
          aws_secretsmanager_secret.private_key_1.arn,
          aws_secretsmanager_secret.private_key_2.arn
        ]
      }
    ]
  })

  depends_on = [ 
    aws_secretsmanager_secret.public_keys
  ]
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach_lambda_policy" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn

  depends_on = [ 
    aws_iam_role.lambda_execution_role,
    aws_iam_policy.lambda_policy
  ]
}

# Lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name = lower("${var.secret_insert}_function")
  role          = aws_iam_role.lambda_execution_role.arn
  package_type  = "Image"
  image_uri     = local.repo_uri
  memory_size   = var.aws_lambda_memory_size
  timeout       = var.aws_lambda_timeout

  depends_on = [ 
    aws_iam_role_policy_attachment.attach_lambda_policy 
  ]
}

# Lambda function invocation
resource "aws_lambda_invocation" "lambda_function" {
  function_name = aws_lambda_function.lambda_function.function_name

  input = jsonencode({
    account_identifier                = var.account_identifier
    snowflake_user                    = var.service_account_user
    get_private_keys_from_aws_secrets = true,
    secret_insert                     = lower(var.secret_insert)
  })

  lifecycle {
    replace_triggered_by = [time_static.rsa_key_pair_rotations]
  }

  depends_on = [ 
    aws_lambda_function.lambda_function 
  ]
}

resource "aws_secretsmanager_secret" "secrets" {
    name = local.base_secrets_path
}

resource "aws_secretsmanager_secret_version" "secrets" {
    secret_id     = aws_secretsmanager_secret.secrets.id
    secret_string = jsonencode({"account_identifier": "<ACCOUNT_IDENTIFIER>",
                                "snowflake_user": "<SNOWFLAKE_USER>",
                                "root_secrets_path": "<ROOT_SECRETS_PATH>",
                                "snowflake_rsa_public_key_1": "<SNOWFLAKE_RSA_PUBLIC_KEY_1>",
                                "snowflake_rsa_public_key_2": "<SNOWFLAKE_RSA_PUBLIC_KEY_2>",
                                "rsa_private_key_pem_1": "<RSA_PRIVATE_KEY_PEM_1>",
                                "rsa_private_key_pem_2": "<RSA_PRIVATE_KEY_PEM_2>"})

    depends_on = [
        aws_secretsmanager_secret.secrets
    ]
}
