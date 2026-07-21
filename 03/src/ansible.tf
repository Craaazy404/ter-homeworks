locals {
  web_vms_list = [for vm in yandex_compute_instance.web : {
    name = vm.name
    ip   = vm.network_interface[0].nat_ip_address
    fqdn = vm.fqdn
  }]
  db_vms_list = [for vm in yandex_compute_instance.db : {
    name = vm.name
    ip   = vm.network_interface[0].nat_ip_address
    fqdn = vm.fqdn
  }]
  storage_vm_info = {
    name = yandex_compute_instance.storage.name
    ip   = yandex_compute_instance.storage.network_interface[0].nat_ip_address
    fqdn = yandex_compute_instance.storage.fqdn
  }
}

resource "local_file" "inventory" {
  filename = "inventory.ini"
  content  = templatefile("${path.module}/inventory.tpl", {
    web     = local.web_vms_list
    db      = local.db_vms_list
    storage = local.storage_vm_info
  })
}
