terraform {
  required_version = "= 1.3.9"

    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
            version = "0.83.0"
        }
    }
    
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-state"
    region     = "ru-central1-a"
    key        = "main/terraform.tfstate"
    access_key = "your_key"
    secret_key = "your_secret"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
    token = var.token
    cloud_id = var.cloud_id
    folder_id = var.folder_id
    zone = var.zone
}


resource "yandex_vpc_network" "network" {
    name = "network"
}


resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

module "swarm" {
  source        = "./modules/instance"
  vpc_subnet_id = yandex_vpc_subnet.subnet1.id
  managers      = 1
  workers       = 2
}
