# IaC Snowflake User RSA key pairs Rotation Terraform module
This Terraform [module](https://developer.hashicorp.com/terraform/language/modules) automates the creation and rotation of RSA key pairs for a Snowflake user. The key pairs are rotated after a configurable number of days from creation, ensuring continuous security.  Note that Snowflake currently only supports two active key pairs per user.

To customize this module for your specific use case, you can leverage its [input](https://developer.hashicorp.com/terraform/language/values/variables) and [output](https://developer.hashicorp.com/terraform/language/values/outputs) variables.  These allow you to tailor key aspects of the module, such as the rotation frequency or Snowflake user details, without modifying the module’s core code.  This flexibility promotes easy reuse and integration into multiple Terraform configurations, improving composability and streamlining infrastructure management.

**Table of Contents**

<!-- toc -->
+ [Let's get started!](#lets-get-started)
+ [Resources](#resources)
<!-- tocstop -->

## Let's get started!

> **Important Notice**
>
> To ensure seamless operation and avoid potential disruptions when using Terraform with time-based rotation, it’s crucial to regularly execute the module within the specified rotation period. Specifically, the execution frequency should match or exceed the configured rotation interval for RSA key pairs. Failing to adhere to this schedule risks the deletion of multiple key pairs in a single execution cycle. Such an occurrence could potentially remove all active RSA keys, thereby disrupting any processes that rely on older keys for accessing Snowflake resources. To maintain uninterrupted access and functionality, it is imperative to keep the module execution timely and consistent with the rotation settings.

**These are the steps**

1. Take care of the cloud environment prequisities listed below:
    > You need to have the following cloud accounts:
    > - [AWS Account](https://signin.aws.amazon.com/) *with SSO configured*
    > - [GitHub Account](https://github.com) *with OIDC configured for AWS*
    > - [Terraform Cloud Account](https://app.terraform.io/)

2. Clone the repo:
    ```shell
    git clone https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module.git
    ```

3. Update the cloned Terraform module's [main.tf](main.tf) by following these steps:

    a. Locate the `terraform.cloud` block and replace **`signalroom`** with your [Terraform Cloud Organization Name](https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/organizations).

    b. In the `terraform.cloud.workspaces` block, replace **`snowflake-user-rsa-key-generator-workspace`** with your [Terraform Cloud Organization's Workspaces Name](https://developer.hashicorp.com/terraform/cloud-docs/workspaces).

4.  Deploy your Terraform module to GitHub by following these steps:

	a. **Commit your module:**  Ensure all changes to your Terraform module are committed to your local Git repository.

	b. **Push to GitHub:**  Push your committed changes to your GitHub repository.  This makes the module available for use in other projects.

	c. **Add a Module Block:**  In the Terraform configuration where you want to use the module, add a module block.  Inside this block, include the following:

	*Source*: Reference the GitHub repository URL where your module is stored.

	*Version*: Specify the appropriate branch, tag, or commit hash to ensure you’re using the correct version of the module.

    d. **Pass Input Variables:**  Within the same module block, pass the required input variables by defining them as key-value pairs:
    Input Variable|Description
    -|-
    `aws_region`|The AWS Region the Terraform configuration uses.
    `aws_account_id`|The AWS Account ID the Terraform configuration uses.
    `snowflake_user`|The Snowflake User who is to be assigned the RSA key pairs for its authentication.
    `day_count`|How many day(s) should the RSA key pairs be rotated for.

    > This module does not output variables through the `outputs.tf` file.  Instead, all sensitive data is securely stored directly in AWS Secrets Manager to ensure robust security and prevent exposure.

## Resources
[Snowfalke key pair authentication and key pair rotation](https://docs.snowflake.com/en/user-guide/key-pair-auth)

[Terraform Resource time_rotating](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating.html)

[Terraform Hidden Gems! Secret Rotation with time_rotating](https://medium.com/cloud-native-daily/terraform-hidden-gems-secret-rotation-with-time-rotating-72ae8683ef7f)
