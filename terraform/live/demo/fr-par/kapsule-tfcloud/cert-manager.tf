module "cert-manager" {
  source  = "particuleio/release/helm"
  version = "~> 1.0"

  release = {
    name          = "cert-manager"
    namespace     = "cert-manager"
    chart         = "cert-manager"
    repository    = "https://charts.jetstack.io"
    chart_version = "v1.0.2"
    values        = <<-EOF
      global:
        podSecurityPolicy:
          enabled: true
          useAppArmor: false
      installCRDs: true
    EOF
  }

  depends_on = [module.kapsule]
}
