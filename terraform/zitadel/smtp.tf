resource "zitadel_email_provider_smtp" "default" {
  sender_address   = "auth@trai.ch"
  sender_name      = "Trai Auth"
  tls              = true
  host             = var.smtp_host
  user             = var.smtp_user
  password         = var.smtp_password
  reply_to_address = "replyto@trai.ch"
  description      = "Resend"
  set_active       = true
}
