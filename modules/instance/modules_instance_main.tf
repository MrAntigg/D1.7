terraform {
  required_version = "= 1.3.9"
  
    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
            version = "0.83.0"
        }
    }
}

data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}

resource "yandex_compute_instance" "vm-manager" {
  count = var.managers
  name     = "swarm-manager-${count.index}"
  hostname = "manager-${count.index}"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    user-data = file("${path.module}/cloud_config.yaml")
  }
}

resource "yandex_compute_instance" "vm-worker" {
  count = var.workers
  name     = "swarm-worker-${count.index}"
  hostname = "worker-${count.index}"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    user-data = file("${path.module}/cloud_config.yaml")
  }
}