resource "cloudflare_record" "www" {
    depends_on = [ google_compute_instance.nginx-instance ]
  zone_id = var.cloudflare_zone_id
  name    = "spaska"
  type    = "A"
  value   = google_compute_instance.nginx-instance.network_interface[0].access_config[0].nat_ip
  ttl     = 1
  proxied = false
}
