terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.2"
    }
  }
}

provider "local" {
  # Configuration options
}

resource "local_file" "hello" {
  content  = "Hello everyone from our DevSecOps class"
  filename = "hello.txt"
}
