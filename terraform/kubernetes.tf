resource "proxmox_vm_qemu" "kubernetes_vms" {
  
  for_each = var.vms
  
  clone = "<nombre de template a usar>"
  target_node = "<node_name>"
  full_clone = false
  name = each.value.hostname
  vmid = each.value.vmid

  os_type = "cloud-init"
  onboot = false
  agent = 1
  scsihw = "virtio-scsi-pci"
  startup = "order=2"
  bootdisk = "scsi0"

  

  ciuser = "${var.user}"
  cipassword = "${var.password}"
  sshkeys = "${var.ssh}"
  ipconfig0 = "ip=${each.value.ip_address},gw=<gateway_ip>"
  nameserver = "<gateway_ip>"


  memory = <memoria_en_MB>

  cpu {
    sockets = <numero_sockets>
    cores = <numero_de_cores>
  }

  network {
    bridge = "<nombre_de_interfaz_Proxmox>"
    model = "virtio"
    firewall = true
    id = 0
  }

  serial {
    id   = 0
    type = "socket"
  }
  vga {
    type = "std"
  }
  
  disks {
    ide {
        ide2 {
             cloudinit {
                storage = "<nombre_storage_cloudinit>"
             }
        }
    }
    scsi{
      scsi0 {
        disk {
        storage = "<nombre_storage_disco>"
        size = "<tamaño_disco_en_GB>"
        replicate = "true"
        }
      }
    }
  }

} 
