resource "libvirt_cloudinit_disk" "ipa-cloud-init" {
  name = "ipa-cloud-init.iso"
  pool = "cluster" 
  user_data      = templatefile(
    "${path.module}/ipa_cloud_init",
    { 
      ssh_pubkey = data.sops_file.ansible_ssh_key.data["ansible_user_ssh_pubkey"]
      root_ca_crt = data.sops_file.root_ca_crt.data["root_ca_crt"]
    }
  )
  network_config = file("${path.module}/ipa_network_config")
}

resource "libvirt_volume" "ipa-root" {
  name = "ipa-root.qcow2"
  pool = "cluster" 
  format = "qcow2"
  size = "10737418240"
  base_volume_name = "fedora38.qcow2"
}

data "sops_file" "ansible_ssh_key" {
  source_file = "${path.module}/../../inventory/group_vars/all/ansible_user.sops.yml"
}

data "sops_file" "root_ca_crt" {
  source_file = "${path.module}/../../inventory/group_vars/all/root-ca.crt.sops.yml"
}