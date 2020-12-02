provider "aws" {
  region = var.region
}

provider "spotinst" {
  # Get credentials from environment variables
  # SPOTINST_TOKEN instead of   token   = local.spotinst_token
  # SPOTINST_ACCOUNT instead of account = local.spotinst_account
}
