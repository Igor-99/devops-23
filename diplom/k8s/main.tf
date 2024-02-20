provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  zone      = var.yc_region_a
}

provider "yandex" {
  alias     = "b"
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  zone      = var.yc_region_a
}

provider "yandex" {
  alias     = "d"
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  zone      = var.yc_region_a
}

