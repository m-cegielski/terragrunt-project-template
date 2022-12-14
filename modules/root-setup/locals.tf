locals {
  parent_level_ous = keys(var.accounts)

  child_level_ous = flatten([
    for pou, cou in var.accounts : formatlist("%s/%s", pou, keys(cou))
  ])

  accounts = flatten([
    for pou, cou in var.accounts : formatlist("%s/%s", pou, flatten([
      for ou, acc in cou : formatlist("%s/%s", ou, keys(acc))
    ]))
  ])

  accounts_map = {
    #for acc in local.accounts : acc => var.accounts[split("/", acc)[0]][split("/", acc)[1]][split("/", acc)[2]]
    for acc in local.accounts : format("%s/%s", split("/", acc)[0], split("/", acc)[2]) => merge(var.accounts[split("/", acc)[0]][split("/", acc)[1]][split("/", acc)[2]], {
      parent_ou = format("%s/%s", split("/", acc)[0], split("/", acc)[1])
    })
  }

}
