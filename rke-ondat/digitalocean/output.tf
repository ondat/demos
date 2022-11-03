
output "rancher_server_url" {
  value = module.rancher_common.rancher_url
}

output "rancher_server_node_ip" {
  value = digitalocean_droplet.rancher_server.ipv4_address
}

# Master nodes
output "rke_master_node_1_ip" {
  value = digitalocean_droplet.master_node_1.ipv4_address
}

output "rke_master_node_2_ip" {
  value = digitalocean_droplet.master_node_2.ipv4_address
}

output "rke_master_node_3_ip" {
  value = digitalocean_droplet.master_node_3.ipv4_address
}

# Worker Nodes
output "rke_worker_node_1_ip" {
  value = digitalocean_droplet.worker_node_1.ipv4_address
}

output "rke_worker_node_2_ip" {
  value = digitalocean_droplet.worker_node_2.ipv4_address
}

output "rke_worker_node_3_ip" {
  value = digitalocean_droplet.worker_node_3.ipv4_address
}

output "rke_worker_node_4_ip" {
  value = digitalocean_droplet.worker_node_4.ipv4_address
}

output "rke_worker_node_5_ip" {
  value = digitalocean_droplet.worker_node_5.ipv4_address
}
