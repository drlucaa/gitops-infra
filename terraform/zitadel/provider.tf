terraform {
  required_providers {
    zitadel = {
      source  = "zitadel/zitadel"
      version = "~> 2.8"
    }
  }
}

provider "zitadel" {
  domain   = "zitadel.zitadel.svc.cluster.local"
  insecure = true
  port     = "8080"

  jwt_profile_json = var.jwt_profile
}
