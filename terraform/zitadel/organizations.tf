resource "zitadel_org" "home" {
  name       = "home"
  is_default = true
}

resource "zitadel_org_member" "admin_user_member" {
  org_id  = zitadel_org.home.id
  user_id = zitadel_human_user.admin_user.id
  roles   = ["ORG_OWNER"]
}
