terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.59.0"
    }
  }
}

provider "google" {
  project = "nzahariev"
  region  = "europe-west3"
}