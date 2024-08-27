terraform {
    cloud {
        organization ="<TERRAFORM CLOUD ORGANIZATION NAME>"

        workspaces {
            name = "<TERRAFORM CLOUD ORGANIZATION's WORKSPACE NAME>"
        }
  }

  required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.64.0"
        }
    }
}

locals {
    repo_name = "iac-snowflake_user-rsa_key_generator"
    repo_url = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${repo_name}"
    function_name = "rsa_key_pairs-generator"

    now = timestamp()
    hour_count = var.day_count*24

    number_of_rsa_key_pairs_to_retain = 2
    sorted_dates = sort(time_rotating.rsa_key_pair_rotations.*.rfc3339)
    dates_and_count = zipmap(time_rotating.rsa_key_pair_rotations.*.rfc3339, range(number_of_rsa_key_pairs_to_retain))
    latest_api_key = lookup(local.dates_and_count, local.sorted_dates[0])
}
