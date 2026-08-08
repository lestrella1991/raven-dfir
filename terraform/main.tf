terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
}

provider "proxmox" {
  pm_api_url ="https://<url_and_port_proxmox>/api2/json"
  pm_api_token_id = "${var.token}"
  pm_api_token_secret = "${var.secret}"
  pm_tls_insecure = true
}


