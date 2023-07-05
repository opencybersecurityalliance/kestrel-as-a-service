variable "build_directory" {
    default = "./build"
}

variable "boot_wait" {
    default = "10s"
}

variable "cpus" {
    default = 2
}

variable "disk_size" {
    default = 60000
}

variable "headless" {
    default = false
}

variable "http_directory" {
    default = "./http"
}

variable "iso_url" {
    type = string
    default = ""
}

variable "iso_checksum" {
    type = string
    default = ""
}

variable "kickstart_file" {
    type = string
    default = "ksfedora.cfg"
}

variable "memory" {
    default = "2048"
}

variable "template" {
    type = string
    default = "fedora-38-x86_64"
}

variable "username" {
    default = "vagrant"
}

variable "provider_name" {
    default = "virtualbox"
}

variable "ssh_timeout" {
    default = "45m"
}

variable "vm_name" {
    type = string
    default = "kaas-controller"
}

source "virtualbox-iso" "fedora_server" {

    vboxmanage = [
       ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
    ]

    boot_command = [
        "<esc><wait>",
        "linux ks=http://{{.HTTPIP}}:{{.HTTPPort}}/ksfedora.cfg",
        "<enter><wait>",
    ]

    boot_wait            = var.boot_wait
    iso_url              = "https://mirror.umd.edu/fedora/linux/releases/37/Server/x86_64/iso/Fedora-Server-dvd-x86_64-37-1.7.iso"
    iso_checksum         = "0a4de5157af47b41a07a53726cd62ffabd04d5c1a4afece5ee7c7a84c1213e4f"
    cpus                 = var.cpus
    disk_size            = var.disk_size
    guest_os_type        = "Fedora_64"
    hard_drive_interface = "sata"
    headless             = var.headless
    http_directory       = var.http_directory
    memory               = var.memory
    output_directory     = "${var.build_directory}/packer-${var.template}-${var.provider_name}"
    shutdown_command     = "echo '${var.username}' | sudo -S shutdown -P now"
    ssh_timeout          = "10m"
    ssh_username         = "vagrant"
    ssh_password         = "vagrant"
}

build {
    sources = ["sources.virtualbox-iso.fedora_server"]

    post-processor "vagrant" {
      keep_input_artifact = true
    }

}