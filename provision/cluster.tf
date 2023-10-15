# Criamos um cluster pegando o nome do arquivo variables.tf e aguardamos ele ficar pronto antes de proseguir.
resource "kind_cluster" "default" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

# configurações do kind para utilizar ingress controler
# Passar flags,expor portas, criar anottations
# Configurar para provisionar um control plane e worker
    node {
      role = "control-plane"
      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }

      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
    }

    node {
      role = "worker"
    }

     node {
      role = "worker"
    }
  }
}
