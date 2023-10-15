# Lista dos providers
provider "kind" {}

provider "kubernetes" {
# Mostra qual config path o provider deve usar. Onde esta o kubeconfig
# Estamos pegando ele apartir do kind. Após o kind criar, ele vai disponibilizar isso após uma variável
  config_path = kind_cluster.default.kubeconfig_path
}

provider "helm" {
  kubernetes {
    config_path = kind_cluster.default.kubeconfig_path
  }
}
