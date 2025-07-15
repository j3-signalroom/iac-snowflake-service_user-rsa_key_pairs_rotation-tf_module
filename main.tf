terraform {
    cloud {
        organization ="signalroom"

        workspaces {
            name = "snowflake-resources-workspace"
        }
  }

  required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 6.3.0"
        }
    }
}
