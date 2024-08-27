variable "aws_region" {
    description = "The AWS Region."
    type        = string
}

variable "aws_account_id" {
    description = "The AWS Account ID."
    type        = string
}

variable "snowflake_user" {
    description = "The Snowflake User."
    type        = string
}

variable "day_count" {
    description = "How many day(s) should the RSA key pair be rotated for."
    type = number
    default = 30
    
    validation {
        condition = var.day_count >= 1
        error_message = "Rolling day count, `day_count`, must be greater than or equal to 1."
    }
}

variable "rsa_key_pair_display_name" {
    description = "A descriptive name for the RSA key pair."
    type = string
    default = "RSA key pair - {date}"
}
