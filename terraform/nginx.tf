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
    #Update Debian and install dependencies
    apt update
    apt install nginx -y
    systemctl start nginx
    systemctl enable nginx
    rm /etc/nginx/sites-available/default
    echo '${file("../web/index.html")}' > /var/www/html/index.html
    echo '${file("../web/nginx.conf")}' > /etc/nginx/sites-available/default
    ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
    apt install certbot python3-certbot-nginx -y
    certbot --nginx -d spaska.zaharievi.dev --non-interactive --agree-tos --email nencho.zahariev@gmail.com --redirect
    systemctl restart nginx

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

output "The website will be available shortly on the following address:" {
  value = "spaska.zaharievi.dev"
}