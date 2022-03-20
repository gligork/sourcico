provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

resource "helm_release" "helm_app" {
  name       = "demo1"
  chart      = "./Helm"

  depends_on = [null_resource.docker_nginx_push, null_resource.docker_php_push, null_resource.modify_value_helm, aws_eks_node_group.private-nodes]
}

resource "null_resource" "export_url" {
    provisioner "local-exec" {
        command = <<-EOT
        sleep 15s
        aws eks --region us-east-1 update-kubeconfig --name ${aws_eks_cluster.demo.name}
        kubectl get svc demo1-demo1-nginx -o jsonpath='{..hostname}' > Access_url.out
        EOT
    }
    depends_on = [helm_release.helm_app]
      
}