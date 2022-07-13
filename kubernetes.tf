resource "kubernetes_namespace" "example" {
    metadata {
      name = var.k8s_namespace
    }
}

resource "kubernetes_deployment" "example" {
  depends_on = [ kubernetes_namespace.example]
  metadata {
    name = "terraform-example"
    labels = {
      test = "MyExampleApp"
    }
    namespace = var.k8s_namespace
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        test = "MyExampleApp"
      }
    }

    template {
      metadata {
        labels = {
          test = "MyExampleApp"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "example"
        }
      }
    }
  }
}