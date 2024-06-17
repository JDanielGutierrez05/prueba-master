# Changelog #

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

`This changelog is not longer maintained. Please, check the main changelog at` [rootChangelog](../changelog.md)

## [2.5.0] - 01/02/2024 ##

### Removed ###

- Notification Events Serverless/Cloudformation stack:
  - Remove `Reports S3`

### Added ###

- Architecture diagram

### Changed ###

- Upgrade Serverless version to 3.25.1

## [2.4.1] - 23/06/2022 ##

### Added ###

- Database credentials in secrets manager for:
  - `Organizations`
  - `Scada`

## [2.4.0] - 05/05/2022 ##

### Added ###

- `Meters` SQS queue, which listen to `Meters` changes at `Usage Management` service
- `Systems` SQS queue, which listen to `Systems` changes at `SCADA` service
- `Devices` SQS queue, which listen to `Devices` changes at `SCADA` service

## [2.3.1] - 31/01/2022 ##

### Fixed ###

- `management-events` CloudFormation stack:
  - `Usage Management`'s `Data Normalization` SNS topic subscription: adds `status` attribute to filter policy
  - `SCADA`'s `Data Normalization` SNS topic subscription: adds `status` attribute to filter policy

## [2.3.0] - 18/01/2022 ##

### Added ###

- `Source Pocket Finder` infrastructure to `management-events` stack:
  - SQS queue
  - `Usage Management`'s `Data Normalization` SNS topic subscription
  - `SCADA`'s `Data Normalization` SNS topic subscription

## [2.2.0] - 29/10/2021 ##

### Changed ###

- Notification Events Serverless/Cloudformation stack:
  - Set reports S3 bucket to be publicly accessible

## [2.1.0] - 29/10/2021 ##

### Added ###

- Management Events Serverless/Cloudformation stack:
  - SSM parameters for cross stack communication related to `Alarms Management`
  - SNS subscription to `Organizations` topic
  - SNS subscription to `Locations` topic
  - SQS queue for `Update Alarm via Location` lambda function
  - SQS queue for `Update Alarm via Organization` lambda function

## [2.0.0] - 08/10/2021 ##

### Added ###

- Database Serverless/Cloudformation stack: MongoDB connection details are stored in Secrets Manager
- Management Events Serverless/Cloudformation stack:
  - SSM parameters for cross stack communication related to `Alarms Management`
  - SNS topic where changes to any `Alarm` are notified
  - SQS queue for `Alarm`'s `Pockets`
- Monitoring Events Serverless/Cloudformation stack:
  - SSM parameters for cross stack communication related to `Alarms Monitoring`
  - SNS topic where the `Alarm`'s status change is notified: `OK` or `ALARM`
  - SQS queue for `Alarm`'s `Finder`
  - SQS queue for `Alarm`'s `Processor`
  - SQS queue for `Alarm`'s `History`
- Notification Events Serverless/Cloudformation stack:
  - SSM parameters for cross stack communication related to `Alarms Notifications`
  - SNS topic for realtime notifications
  - SQS queue for realtime notifications
  - SQS queue for scheduled notifications

### Deprecated ###

### Fixed ###

### Removed ###

### Security ###

### Unreleased ###
