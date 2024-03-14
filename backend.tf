terraform {
  backend "gcs" {
    bucket  = "spaska-state"
    prefix  = "terraform/state"
    credentials = "./nzahariev-key.json"
  }
}
