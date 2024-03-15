terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.59.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "4.26.0"
    }    
  }
}

provider "google" {
  project = "nzahariev"
  region  = "europe-west3"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}