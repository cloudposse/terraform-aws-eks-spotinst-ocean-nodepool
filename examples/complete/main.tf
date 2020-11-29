module "example" {
  #source = "../.."
  source = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.21.0"

  attributes = [var.example]

  context = module.this.context
}
