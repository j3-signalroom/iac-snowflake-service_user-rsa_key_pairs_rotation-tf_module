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
