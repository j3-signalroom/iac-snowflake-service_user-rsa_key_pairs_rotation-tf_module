# IaC Snowflake User RSA key pairs Rotation Terraform module
This Terraform [module](https://developer.hashicorp.com/terraform/language/modules) automates the creation and rotation of RSA key pairs for a Snowflake user. The key pairs are rotated after a configurable number of days from creation, ensuring continuous security.  Note that Snowflake currently only supports two active key pairs per user.

To customize this module for your specific use case, you can leverage its [input](https://developer.hashicorp.com/terraform/language/values/variables) and [output](https://developer.hashicorp.com/terraform/language/values/outputs) variables.  These allow you to tailor key aspects of the module, such as the rotation frequency or Snowflake user details, without modifying the module’s core code.  This flexibility promotes easy reuse and integration into multiple Terraform configurations, improving composability and streamlining infrastructure management.

**Table of Contents**

<!-- toc -->
+ [Let's get started!](#lets-get-started)
    - [Module Input Variables](#module-input-variables)
    - [Module Output Variables](#module-output-variables)
+ [Resources](#resources)
<!-- tocstop -->

## Let's get started!

> **Important Notice**
>
> To ensure seamless operation and avoid potential disruptions when using Terraform with time-based rotation, it’s crucial to regularly execute the module within the specified rotation period. Specifically, the execution frequency should match or exceed the configured rotation interval for RSA key pairs. Failing to adhere to this schedule risks the deletion of multiple key pairs in a single execution cycle. Such an occurrence could potentially remove all active RSA keys, thereby disrupting any processes that rely on older keys for accessing Snowflake resources. To maintain uninterrupted access and functionality, it is imperative to keep the module execution timely and consistent with the rotation settings.


In the [main.tf](main.tf) replace **`<TERRAFORM CLOUD ORGANIZATION NAME>`** in the `terraform.cloud` block with your [Terraform Cloud Organization Name](https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/organizations) and **`<TERRAFORM CLOUD ORGANIZATION's WORKSPACE NAME>`** in the `terraform.cloud.workspaces` block with your [Terraform Cloud Organization's Workspaces Name](https://developer.hashicorp.com/terraform/cloud-docs/workspaces).

### Module Input Variables

To initiate the creation and rotation of RSA key pairs, specify the following input variables in your Terraform configuration:

Variable|Description
-|-
`aws_region`|The AWS Region.
`aws_account_id`|The AWS Account ID.
`snowflake_user`|The Snowflake User.
`day_count`|How many day(s) should the RSA key pair be rotated for.

### Module Output Variables
This module does not output variables through the `outputs.tf` file.  Instead, all sensitive data is securely stored directly in AWS Secrets Manager to ensure robust security and prevent exposure.

## Resources
[Terraform Resource time_rotating](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating.html)

[Terraform Hidden Gems! Secret Rotation with time_rotating](https://medium.com/cloud-native-daily/terraform-hidden-gems-secret-rotation-with-time-rotating-72ae8683ef7f)
