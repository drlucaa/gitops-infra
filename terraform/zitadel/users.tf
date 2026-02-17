resource "zitadel_human_user" "admin_user" {
  org_id             = zitadel_org.home.id
  user_name          = "luca"
  first_name         = "Luca"
  last_name          = "Fondo"
  nick_name          = "Luca"
  display_name       = "Luca Fondo"
  email              = "luca.fondo@trai.ch"
  is_email_verified  = true
  preferred_language = "en"
}
