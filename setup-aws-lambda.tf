data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Create the Lambda execution role and policy
resource "aws_iam_role" "generator_lambda" {
  name = "${var.secret_insert}_role"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "generator_lambda_policy" {
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
          "arn:aws:secretsmanager:*:*:secret:/snowflake_resource/${var.secret_insert}/*"
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
resource "aws_iam_role_policy_attachment" "generator_lambda_policy_attachment" {
  role       = aws_iam_role.generator_lambda.name
  policy_arn = aws_iam_policy.generator_lambda_policy.arn

  depends_on = [ 
    aws_iam_role.generator_lambda,
    aws_iam_policy.generator_lambda_policy 
  ]
}

# Lambda function
resource "aws_lambda_function" "generator_lambda_function" {
  function_name = "${var.secret_insert}_function"
  role          = aws_iam_role.generator_lambda.arn
  package_type  = "Image"
  image_uri     = local.repo_uri
  memory_size   = var.aws_lambda_memory_size
  timeout       = var.aws_lambda_timeout

  depends_on = [ aws_iam_role.generator_lambda ]
}

# Lambda function invocation
resource "aws_lambda_invocation" "generator_lambda_function" {
  function_name = aws_lambda_function.generator_lambda_function.function_name

  input = jsonencode({
    user                              = var.service_account_user
    account_identifier                = var.snowflake_account
    get_private_keys_from_aws_secrets = True,
    secret_insert                     = var.secret_insert
  })

  lifecycle {
    replace_triggered_by = [time_static.rsa_key_pair_rotations]
  }

  depends_on = [ aws_lambda_function.generator_lambda_function ]
}
