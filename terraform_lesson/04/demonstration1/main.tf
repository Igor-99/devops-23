terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
  
    backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "bucket-name-dev"
    region = "ru-central1-a"
    key = "terraform.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gd6skf5b8nefglqn67/etnk0e1tr0lss2tir509"
    dynamodb_table = "tflock-develop"
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}


module "vpc_module" {
  source = "./vpc_module"
  vpc_name = "develop"
  vpc_subnet_name = "develop-ru-central1-a"
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]  
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vpc_module.vpc.id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [ module.vpc_module.subnet.id ]
  instance_name   = "web"
  instance_count  = 2
  image_family    = "ubuntu-2004-lts"
  public_ip       = true
  
  metadata = {
      user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
      serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
 
 vars = {
   ssh_authorized_keys = local.server_ssh_key
  } 
}

