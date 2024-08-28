# IAM role for Lambda execution
resource "aws_iam_role" "lambda_function_role" {
  name = "lambda_function_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach the AWSLambdaBasicExecutionRole policy to the role
resource "aws_iam_role_policy_attachment" "lambda_exec_policy_attach" {
  role       = aws_iam_role.lambda_function_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name = local.function_name

  # Provide the IAM role
  role = aws_iam_role.lambda_function_role.arn

  # Specify the container image URI from ECR
  image_uri = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${local.repo_name}"

  # Specify the amount of memory and timeout
  memory_size = 128
  timeout     = 30
}

# Create a CloudWatch log group for the Lambda function
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_function.function_name}"
  retention_in_days = 7
}

# Lambda function invocation
resource "aws_lambda_invocation" "lambda_function" {
  function_name = aws_lambda_function.lambda_function.function_name

  input = jsonencode({
    user = var.snowflake_user
    account = var.snowflake_account
  })

  depends_on = [aws_lambda_function.lambda_function]

  lifecycle {
    replace_triggered_by = [time_static.rsa_key_pair_rotations[count.index]]
  }
}
