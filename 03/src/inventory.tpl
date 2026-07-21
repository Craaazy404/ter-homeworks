[webservers]
%{ for vm in web ~}
${vm.name} ansible_host=${vm.ip} fqdn=${vm.fqdn}
%{ endfor ~}

[databases]
%{ for vm in db ~}
${vm.name} ansible_host=${vm.ip} fqdn=${vm.fqdn}
%{ endfor ~}

[storage]
${storage.name} ansible_host=${storage.ip} fqdn=${storage.fqdn}
