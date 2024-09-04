# Changelog
All notable changes to this project will be documented in this file.

The format is base on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.30.00.000] - 2024-09-04
### Changed
- The lambda function should only update the secrets, never create them, because the Terraform module needs to handle that task in order for Terraform to manage the creation and destruction of the secrets.

## [0.20.00.000] - 2024-09-02
### Added
- Enable the passing of performance parameters to the customize AWS Lambda.

### Changed
- Updated the description of the module's functionality.

## [0.10.00.000] - 2024-08-29
### Added
- Module includes output variable(s) as well.

## [0.03.00.000] - 2024-08-28
### Added
- Set up the Lambda execution policy.

## [0.02.02.000] - 2024-08-28
### Fixed
- Specified the entry point to the Lambda function.
- Specified the runtime of the Lambda function.
- Removed `replace_triggered_by = [time_static.rsa_key_pair_rotations[count.index]]` from `resource "aws_lambda_invocation" "lambda_function" {}`.

## [0.02.01.000] - 2024-08-28
### Fixed
- Was not referencing local variables properly.

## [0.02.00.000] - 2024-08-27
### Fixed
- Passing the Snowflake Account identifier instead of the AWS Account ID.

## [0.01.00.000] - 2024-08-27
### Added
- First release.