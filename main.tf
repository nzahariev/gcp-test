resource "google_compute_instance" "nginx-instance" {
  depends_on = [ google_compute_firewall.allow-http-https ]
  name         = "spaska-nginx"
  machine_type = "n2-standard-2"
  zone         = "europe-west3-c"

  tags = ["nginx-vm"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = <<EOF
    # Update Debian and install dependencies \
    apt update \
    apt install git curl gnupg2 ca-certificates lsb-release debian-archive-keyring nginx -y \
    systemctl start nginx \
    systemctl enable nginx
EOF

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "nzahariev@nzahariev.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

output "instance_public_ip" {
  value = google_compute_instance.nginx-instance.network_interface[0].access_config[0].nat_ip
}