resource "aws_ecr_repository" "main_ecr" {
  name                 = "main_ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "modify_value_helm" {
    provisioner "local-exec" {
        command = <<-EOT
        sed -i 's%<replace_ecr>%${aws_ecr_repository.main_ecr.repository_url}%' Helm/values.yaml
        EOT
    }
    depends_on = [aws_ecr_repository.main_ecr]
}

resource "null_resource" "docker_nginx_push" {
    provisioner "local-exec" {
        command = <<-EOT
        docker build -f Docker/DockerfileNginx -t ${aws_ecr_repository.main_ecr.repository_url}:nginx ./Docker
        aws ecr get-login-password \
            --region us-east-1\
        | docker login \
            --username AWS \
            --password-stdin ${aws_ecr_repository.main_ecr.registry_id}.dkr.ecr.us-east-1.amazonaws.com

        docker push ${aws_ecr_repository.main_ecr.repository_url}:nginx
EOT
    }
  depends_on = [aws_ecr_repository.main_ecr]
}

resource "null_resource" "docker_php_push" {
    provisioner "local-exec" {
        command = <<-EOT
        docker build -f Docker/DockerfilePhp -t ${aws_ecr_repository.main_ecr.repository_url}:php ./Docker
        aws ecr get-login-password \
            --region us-east-1\
        | docker login \
            --username AWS \
            --password-stdin ${aws_ecr_repository.main_ecr.registry_id}.dkr.ecr.us-east-1.amazonaws.com

        docker push ${aws_ecr_repository.main_ecr.repository_url}:php
EOT
    }
  depends_on = [aws_ecr_repository.main_ecr]
}