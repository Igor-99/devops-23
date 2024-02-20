resource "local_file" "k8s" {
  content = <<-DOC
 
    # ## Configure 'ip' variable to bind kubernetes services on a
    # ## different ip than the default iface
    # ## We should set etcd_member_name for etcd cluster. The node that is not a etcd member do not need to set the value, or can set the empty$
    [all]
    master ansible_host=${yandex_compute_instance.master.network_interface.0.ip_address} ip=${yandex_compute_instance.master.network_interface.0.ip_address}
    node1 ansible_host=${yandex_compute_instance.node1.network_interface.0.ip_address} ip=${yandex_compute_instance.node1.network_interface.0.ip_address}
    node2 ansible_host=${yandex_compute_instance.node2.network_interface.0.ip_address} ip=${yandex_compute_instance.node2.network_interface.0.ip_address}
    node3 ansible_host=${yandex_compute_instance.node3.network_interface.0.ip_address} ip=${yandex_compute_instance.node3.network_interface.0.ip_address}


    [kube_control_plane]
    master

    [etcd]
    master

    [kube_node]
    node1
    node2
    node3

    [calico_rr]

    [k8s_cluster:children]
    kube_control_plane
    kube_node
    calico_rr

    DOC
  filename = "./ansible/k8s.ini"

  depends_on = [
    yandex_compute_instance.master,
    yandex_compute_instance.node1,
    yandex_compute_instance.node2,
    yandex_compute_instance.node3
  ]
}
