resource "null_resource" "ram_setup" {
  provisioner "local-exec" {
    command = "aws ram enable-sharing-with-aws-organization"
  }
}
