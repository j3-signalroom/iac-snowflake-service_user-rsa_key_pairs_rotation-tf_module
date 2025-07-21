resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.secret_insert}_role"

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
  name        = "${var.secret_insert}_policy"
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
    aws_secretsmanager_secret.public_keys,
    aws_secretsmanager_secret.private_key_1,
    aws_secretsmanager_secret.private_key_2,
    aws_secretsmanager_secret.private_key_pem_1,
    aws_secretsmanager_secret.private_key_pem_2
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
  function_name = "${var.secret_insert}_function"
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
    user                              = var.service_account_user
    account_identifier                = var.account_identifier
    get_private_keys_from_aws_secrets = true,
    secret_insert                     = var.secret_insert
  })

  lifecycle {
    replace_triggered_by = [time_static.rsa_key_pair_rotations]
  }

  depends_on = [ 
    aws_lambda_function.lambda_function 
  ]
}
