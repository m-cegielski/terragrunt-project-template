locals {
  email = "cegielski.michal.work@gmail.com"
}

include "backend" {
  path = find_in_parent_folders()
}

terraform {
  source = "../..//modules/root-setup"
}

inputs = {
  accounts = {
    main = {
      shared = {
        services = {
          name                       = "main-shared-services"
          email                      = replace(local.email, "@", "+mgmt@")
          iam_user_access_to_billing = "DENY"
        },
        security = {
          email                      = replace(local.email, "@", "+sec@")
          iam_user_access_to_billing = "DENY"
        }
      }
    }
    department-a = {
      non-prod = {
        dev = {
          email                      = replace(local.email, "@", "+a.dev@")
          iam_user_access_to_billing = "DENY"
        }
      }
      prod = {
        prod = {
          email                      = replace(local.email, "@", "+a.prod@")
          iam_user_access_to_billing = "DENY"
        }
      }
    }
  }

  state_bucket_name = "c-mi-org-tf-state"
  state_bucket_path = path_relative_to_include()
}
