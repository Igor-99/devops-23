variable "yc_token" {
    description = "ID Yandex.Token"
    default = "y0_AgAAAAAjne4yAATuwQAAAADXPxiPyjnWwRVFQYi03XWrnYerNk9lXPU"
    sensitive = true
}

variable "yc_cloud_id" {
    description = "ID Yandex.Cloud"
    default = "b1gd6skf5b8nefglqn67"
    sensitive = true
}

variable "yc_region_a" {
    description = "Region Zone A"
    default = "ru-central1-a"
}

variable "yc_region_b" {
    description = "Region Zone B"
    default = "ru-central1-b"
}

variable "yc_region_c" {
    description = "Region Zone C"
    default = "ru-central1-c"
}

variable "master" {
    description = "Initial Master-node name"
    default = "master"
}

variable "masters_count" {
    description = "Quantity of master-node"
    default = 1
}

variable "node" {
    description = "Initial Worker-node name"
    default = "node"
}

variable "nodes_count" {
    description = "Quantity of worker-node"
    default = 3
}
