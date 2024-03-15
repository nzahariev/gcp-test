variable "cloudflare_api_token" {
  sensitive = true
  description = "stored as github secret"
}

variable "cloudflare_zone_id" {
  sensitive = true
  description = "stored as github secret"
}