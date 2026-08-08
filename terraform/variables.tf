variable "user" {
  description = "Machine user"
  type = string
  sensitive = true
}

variable "password" {
  description = "User password"
  type = string
  sensitive = true
}

variable "ssh" {
  description = "SSH key"
  type = string
  sensitive = true
}

variable "token" {
  description = "API user"
  type = string
  sensitive = true
}

variable "secret" {
  description = "API user"
  type = string
  sensitive = true
}

variable "vms" {
  type = map(object({
    vmid        = number
    hostname    = string
    ip_address  = string
  }))
  default = {
    "node-1" = {
      vmid       = <ID_Number>
      hostname   = "node-1"
      ip_address = "IP/CIDR"
    },
    "node-2" = {
      vmid       = <ID_Number>
      hostname   = "node-2"
      ip_address = "IP/CIDR"
    },
    "node-3" = {
      vmid       = <ID_Number>
      hostname   = "node-3"
      ip_address = "IP/CIDR"
    }
  }
}