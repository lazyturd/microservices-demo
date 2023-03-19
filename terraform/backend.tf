terraform {
    backend "remote" {
        hostname = "app.terraform.io"
        organization = "Sock-shop"

        workspaces {
          name = "sock-workspace"
        }
    }
}