module "kapsule" {
  source              = "particuleio/kapsule/scaleway"
  version             = "~> 1.0"
  cluster_name        = "tkap-s3"
  cluster_description = "tkap-s3"
  admission_plugins   = ["PodSecurityPolicy"]
  kubernetes_version  = "1.19.2"

  node_pools = {
    tkap = {
      size        = 2
      max_size    = 5
      min_size    = 2
      autoscaling = true
    }
  }
}

module "psp" {
  source     = "particuleio/psp/kubernetes"
  version    = "~> 1.0"
  depends_on = [module.kapsule]
}

output "kubeconfig" {
  value = module.kapsule.kubeconfig[0]["config_file"]
}
