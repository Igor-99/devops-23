resource "local_file" "k8s" {
  content = <<-DOC

    # ## Configure 'ip' variable to bind kubernetes services on a
    # ## different ip than the default iface
    # ## We should set etcd_member_name for etcd cluster. The node that is not a etcd member do not need to set the value, or can set the empty$
    [all]
    master-1.ru-central1.internal ansible_host=${yandex_compute_instance.master[0].network_interface.0.ip_address} ip=${yandex_compute_instance.master[0].network_interface.0.ip_address}
    node-1.ru-central1.internal ansible_host=${yandex_compute_instance.node[0].network_interface.0.ip_address} ip=${yandex_compute_instance.node[0].network_interface.0.ip_address}
    node-2.ru-central1.internal ansible_host=${yandex_compute_instance.node[1].network_interface.0.ip_address} ip=${yandex_compute_instance.node[1].network_interface.0.ip_address}
    node-3.ru-central1.internal ansible_host=${yandex_compute_instance.node[2].network_interface.0.ip_address} ip=${yandex_compute_instance.node[2].network_interface.0.ip_address}
    [kube_control_plane]
    master-1.ru-central1.internal
    [etcd]
    master-1.ru-central1.internal
    [kube_node]
    node-1.ru-central1.internal
    node-2.ru-central1.internal
    node-3.ru-central1.internal
    [calico_rr]
    [k8s_cluster:children]
    kube_control_plane
    kube_node
    calico_rr
    DOC
  filename = "./ansible/k8s.ini"

  depends_on = [
    yandex_compute_instance.master,
    yandex_compute_instance.node
  ]
}
