terraform {
  required_providers {
    zitadel = {
      source  = "zitadel/zitadel"
      version = "~> 2.8"
    }
  }
}

provider "zitadel" {
  domain   = "auth.trai.ch"
  insecure = false
  port     = "443"

  jwt_profile_json = var.jwt_profile
}
