resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stackr"
  version    = "45.7.1"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
}