# DO infrastructure resources

resource "tls_private_key" "global_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_sensitive_file" "ssh_private_key_pem" {
  filename        = "${path.module}/id_rsa"
  content         = tls_private_key.global_key.private_key_pem
  file_permission = "0600"
}

resource "local_file" "ssh_public_key_openssh" {
  filename = "${path.module}/id_rsa.pub"
  content  = tls_private_key.global_key.public_key_openssh
}

# Temporary key pair used for SSH accesss
resource "digitalocean_ssh_key" "quickstart_ssh_key" {
  name       = "${var.prefix}-droplet-ssh-key"
  public_key = tls_private_key.global_key.public_key_openssh
}

# DO droplet for creating a single node RKE cluster and installing the Rancher server
resource "digitalocean_droplet" "rancher_server" {
  name     = "${var.prefix}-rancher-server"
  image    = "ubuntu-20-04-x64"
  region   = var.do_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.quickstart_ssh_key.fingerprint]

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# Rancher resources
module "rancher_common" {
  source = "../rancher-common"

  node_public_ip             = digitalocean_droplet.rancher_server.ipv4_address
  node_internal_ip           = digitalocean_droplet.rancher_server.ipv4_address_private
  node_username              = local.node_username
  ssh_private_key_pem        = tls_private_key.global_key.private_key_pem
  rancher_kubernetes_version = var.rancher_kubernetes_version

  cert_manager_version = var.cert_manager_version
  rancher_version      = var.rancher_version

  rancher_server_dns = join(".", ["rancher", digitalocean_droplet.rancher_server.ipv4_address, "sslip.io"])
  admin_password     = var.rancher_server_admin_password

  workload_kubernetes_version = var.workload_kubernetes_version
  workload_cluster_name       = "quickstart-do-custom"
}

# DO droplet for creating a separate RKE workload cluster 

# Create 3 master/control plane nodes
# master_node_1
resource "digitalocean_droplet" "master_node_1" {
  name     = "${var.prefix}-master-node-1"
  image    = "ubuntu-20-04-x64"
  region   = var.do_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.quickstart_ssh_key.fingerprint]

  user_data = templatefile(
    "${path.module}/files/userdata_etcd_controlplane_node.template",
    {
      register_command = module.rancher_common.custom_cluster_command
    }
  )

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# master_node_2
resource "digitalocean_droplet" "master_node_2" {
  name     = "${var.prefix}-master-node-2"
  image    = "ubuntu-20-04-x64"
  region   = var.do_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.quickstart_ssh_key.fingerprint]

  user_data = templatefile(
    "${path.module}/files/userdata_etcd_controlplane_node.template",
    {
      register_command = module.rancher_common.custom_cluster_command
    }
  )

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# master_node_3
resource "digitalocean_droplet" "master_node_3" {
  name     = "${var.prefix}-master-node-3"
  image    = "ubuntu-20-04-x64"
  region   = var.do_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.quickstart_ssh_key.fingerprint]

  user_data = templatefile(
    "${path.module}/files/userdata_etcd_controlplane_node.template",
    {
      register_command = module.rancher_common.custom_cluster_command
    }
  )

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# Create 5 worker nodes
# worker_node_1
resource "digitalocean_droplet" "worker_node_1" {
  name     = "${var.prefix}-worker-node-1"
  image    = "ubuntu-20-04-x64"
  region   = var.do_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.quickstart_ssh_key.fingerprint]

  user_data = templatefile(
    "${path.module}/files/userdata_worker_node.template",
    {
      register_command = module.rancher_common.custom_cluster_command
    }
  )

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# worker_node_2
resource "digitalocean_droplet" "worker_node_2" {
  name     = "${var.prefix}-worker-node-2"
  image    = "ubuntu-20-04-x64"
  region   = var.do_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.quickstart_ssh_key.fingerprint]

  user_data = templatefile(
    "${path.module}/files/userdata_worker_node.template",
    {
      register_command = module.rancher_common.custom_cluster_command
    }
  )

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# worker_node_3
resource "digitalocean_droplet" "worker_node_3" {
  name     = "${var.prefix}-worker-node-3"
  image    = "ubuntu-20-04-x64"
  region   = var.do_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.quickstart_ssh_key.fingerprint]

  user_data = templatefile(
    "${path.module}/files/userdata_worker_node.template",
    {
      register_command = module.rancher_common.custom_cluster_command
    }
  )

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# worker_node_4
resource "digitalocean_droplet" "worker_node_4" {
  name     = "${var.prefix}-worker-node-4"
  image    = "ubuntu-20-04-x64"
  region   = var.do_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.quickstart_ssh_key.fingerprint]

  user_data = templatefile(
    "${path.module}/files/userdata_worker_node.template",
    {
      register_command = module.rancher_common.custom_cluster_command
    }
  )

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# worker_node_5
resource "digitalocean_droplet" "worker_node_5" {
  name     = "${var.prefix}-worker-node-5"
  image    = "ubuntu-20-04-x64"
  region   = var.do_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.quickstart_ssh_key.fingerprint]

  user_data = templatefile(
    "${path.module}/files/userdata_worker_node.template",
    {
      register_command = module.rancher_common.custom_cluster_command
    }
  )

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}
