# IaC Snowflake User RSA key pairs Rotation Terraform module
This Terraform [module](https://developer.hashicorp.com/terraform/language/modules) provides a comprehensive solution for managing the lifecycle of RSA key pairs used for authenticating a Snowflake service account. It utilizes a customized AWS Lambda function to automate the creation and rotation of RSA key pairs at regular intervals, which are defined by the user (e.g., every 30 days since the last key generation).

The module allows you to set a specific rotation schedule, ensuring that new RSA key pairs are created and deployed automatically, reducing the risk of unauthorized access due to compromised or outdated keys. By integrating directly with Snowflake, this module simplifies the key management process, providing seamless, hands-free automation. It also supports robust security practices by keeping the key pairs fresh, eliminating manual errors, and adhering to industry-standard cryptographic protocols.

Overall, this module is a vital tool for maintaining a secure, efficient, and automated RSA key management process in cloud environments that utilize Snowflake.

> _Currently, Snowflake **only supports two** actve RSA key pairs for a given user._

To customize this Terraform module for your specific requirements, you can utilize its configurable [input](https://developer.hashicorp.com/terraform/language/values/variables) and [output](https://developer.hashicorp.com/terraform/language/values/outputs) variables. These variables enable you to adjust key parameters such as the frequency of RSA key pair rotation, the details of the Snowflake user, and other settings relevant to your environment. This approach allows you to adapt the module's behavior to fit different operational needs without directly modifying its underlying code.

By using these variables, you can:
- **Set the Rotation Frequency**: Define how often RSA key pairs should be rotated, aligning with your organization's security policies.
- **Configure Snowflake User Details**: Specify attributes account names, or any other Snowflake-specific settings.
- **Adjust AWS Lambda Settings**: Customize Lambda function parameters, such as memory size and timeout, to optimize performance for your use case.

This flexibility makes the module highly reusable and easier to integrate into various Terraform configurations, enhancing composability and streamlining infrastructure management. It allows for quick adjustments to meet different security requirements or deployment scenarios, reducing the time and effort needed to maintain and adapt infrastructure as code (IaC) practices across multiple projects or environments.

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
    `snowflake_account`|The Snowflake Account identifer issued to your organization.
    `service_account_user`|The Snowflake service account user who is to be assigned the RSA key pairs for its authentication.
    `day_count`|_**(Optional and defaults to 30 days)**_  How many day(s) should the RSA key pairs be rotated for.
    `aws_lambda_memory_size`|_**(Optional and defaults to 128 MB)**_  Lambda allocates CPU power in proportion to the amount of memory configured. Memory is the amount of memory available to your Lambda function at runtime. You can increase or decrease the memory and CPU power allocated to your function using the Memory setting. You can configure memory between 128 MB and 10,240 MB in 1-MB increments. At 1,769 MB, a function has the equivalent of one vCPU (one vCPU-second of credits per second).
    `aws_lambda_timeout`|_**(Optional and defaults to 900 seconds)**_  Lambda runs your code for a set amount of time before timing out. Timeout is the maximum amount of time in seconds that a Lambda function can run. The default value for this setting is 3 seconds, but you can adjust this in increments of 1 second up to a maximum value of 900 seconds (15 minutes).
    `aws_log_retention_in_days`|_**(Optional and defaults to 7 days)**_  Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, and 0. If you select 0, the events in the log group are always retained and never expire.

    e. **Output Variables:**  These output variables allow data produced by the module to be exposed to the parent module (the configuration that calls the module), making it possible to use the results of the module's actions elsewhere in the Terraform deployment.

    Output Variable|Description
    -|-
    `active_rsa_public_key`|Specifies the current active RSA public key.
    `active_rsa_public_key_number`|Specifies current active RSA public key number.

## Resources
[Snowflake key pair authentication and key pair rotation](https://docs.snowflake.com/en/user-guide/key-pair-auth)

[Terraform Resource time_rotating](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating.html)

[Terraform Hidden Gems! Secret Rotation with time_rotating](https://medium.com/cloud-native-daily/terraform-hidden-gems-secret-rotation-with-time-rotating-72ae8683ef7f)
