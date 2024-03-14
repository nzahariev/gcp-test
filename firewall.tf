resource "google_compute_firewall" "allow-http-https" {
  project     = "nzahariev"
  name        = "allow-http-and-https"
  network     = "default"
  description = "Allows ingress traffic on ports 80 and 443 for my nginx vm"

  allow {
    protocol  = "tcp"
    ports     = ["80", "443"]
  }

  priority = "1000"

  target_tags = ["nginx-vm"]
  source_ranges = ["0.0.0.0/0"]
}