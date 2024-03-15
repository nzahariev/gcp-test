terraform {
  backend "gcs" {
    bucket  = "spaska-state"
    prefix  = "terraform/state"
  }
}
