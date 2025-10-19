# Changelog
All notable changes to this project will be documented in this file.

The format is base on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.00.00.000] - TBD
### Changed
- Issue [#202](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/202)

## [0.51.00.000] - 2025-08-31
### Changed
- Issue [#200](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/200)

## [0.50.00.000] - 2025-08-08
### Added
- Issue [#143](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/143)
- Issue [#145](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/145)
- Issue [#148](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/148)
- Issue [#150](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/150)
- Issue [#160](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/160)
- Issue [#188](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/188)
- Issue [#190](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/190)
- Issue [#194](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/194)

### Changed 
- Issue [#165](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/165)
- Issue [#175](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/175)
- Issue [#177](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/177)
- Issue [#186](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/186)
- Issue [#196](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/196)

### Fixed 
- Issue [#158](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/158)
- Issue [#162](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/162)

## [0.49.00.000] - 2025-07-15
### Added
- Issue [#141](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/141)

## [0.48.00.000] - 2025-07-15
### Added
- Issue [#137](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/137)

### Changed
- Issue [#139](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/139)

## [0.47.00.000] - 2025-06-03
### Changed
- Issue [#133](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/133)

## [0.46.01.000] - 2025-05-31
### Added
- Issue [#131](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/131)

## [0.46.00.000] - 2025-05-19
### Added
- Issue [#128](https://github.com/j3-signalroom/iac-snowflake-user-rsa_key_pairs_rotation-tf_module/issues/128)

## [0.45.00.000] - 2025-04-19
### Changed
- Upgraded the version of Terraform AWS Provider to `5.95.0`.

## [0.44.00.000] - 2025-01-09
### Changed
- Upgraded the version of Terraform AWS Provider to `5.83.0`.

## [0.43.00.000] - 2024-11-27
### Changed
- Upgraded the version of Terraform AWS Provider to `5.78.0`.

## [0.42.00.000] - 2024-11-22
### Changed
- Upgraded the version of Terraform AWS Provider to `5.77.0`.

## [0.41.00.000] - 2024-11-08
### Changed
- Upgraded the version of Terraform AWS Provider to `5.75.0`.

## [0.40.00.000] - 2024-09-06
### Added
- Addede the ability to customize the secrets path.

## [0.31.00.000] - 2024-09-05
### Changed
- Upgraded the version of Terraform AWS Provider to `5.66.0`.

## [0.30.00.000] - 2024-09-04
### Added
- Enable the passing of performance parameters to the customize AWS Lambda.

### Changed
- The lambda function should only update the secrets, never create them, because the Terraform module needs to handle that task in order for Terraform to manage the creation and destruction of the secrets.
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