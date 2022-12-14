# Terragrunt project template

Simple evaluation of using Terragrunt in a multi-account AWS deployment.

Top level directories:
  - accounts - main code for provisioning resources in the accounts
  - init - simple AVM (Account Vending Machine) aka AWS Landing Zone, directory in which organization, with member accounts, is provisioned. Uses separate state bucket but allows reading non sensitive details about organization to IAM entities in member accounts. Setup of OUs, Accounts, IAM users, IAM roles, state buckets. Designed to be executed with administration priviledges in master organization account.
  - modules - modules used for provisioning
  - services - HCL files used to reduce duplication of code when services are deployed multiple times

Template can be suitable for small multi-account projects, however it might be required to group accounts in department directories and add region subdirectories.

### AVM

The most powerful feature of this template is use of AVM and reading account values out of it which greatly reduces hard coding of account related details in Terragrunt configuration files.

### Resources

Resources created by modules should not be treated as secure, they were created to provide base functionality.
