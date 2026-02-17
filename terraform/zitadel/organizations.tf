resource "zitadel_org" "home" {
  name       = "home"
  is_default = true
  admins = [
    {
      user_id = zitadel_human_user.admin_user.id
      roles   = ["ORG_OWNER"]
    }
  ]

}

