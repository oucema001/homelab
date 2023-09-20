terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
    sops = {
      source = "carlpett/sops"
      version = "1.0.0"
    }
  }
}