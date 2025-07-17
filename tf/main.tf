terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "local" {}

resource "local_file" "medieval_congrats" {
  filename = "${path.module}/success.txt"

  content  = <<EOT
Hear ye, hear ye!

Thou hast summoned the ancient and mystical powers of Terraform and forged thy very first deployment into the realm of DevOps.

🎉 Huzzah! 🎉

Let it be known across the kingdom, from the farthest node to the deepest pod, that henceforth thou art a DevOps sorcerer of the highest order!

"And the Lord spake, saying, 'First shalt thou take out the Holy Pin, then shalt thou count to three, no more, no less...'" — *Monty Python and the Holy Grail*

Go forth, noble engineer, and let your infrastructure be ever declarative.

Signed,
Sir Git of the Branch
EOT
}
