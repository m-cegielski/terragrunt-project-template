output "encrypted_user_passwords" {
  value = {
    for user, pgp in var.users : user => module.user[user].keybase_password_pgp_message
  }
}

output "get_password_commands" {
  value = {
    for user, pgp in var.users : user => module.user[user].keybase_password_decrypt_command
  }
}
