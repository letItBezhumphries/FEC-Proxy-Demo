resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair-${terraform.workspace}"
  public_key = file("${path.root}/${var.PATH_TO_PUBLIC_KEY}")
  lifecycle {
    ignore_changes = [public_key]
  }
}
