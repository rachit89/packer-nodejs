packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "packer-ami-rachit" {
    ami_name = "nodejs-packer-ami-rachit"
    source_ami = "ami-0960ab670c8bb45f3"
    instance_type = "t3a.small"
    region = "us-east-2"
    ssh_username = "ubuntu"
}

build {
    sources = [
        "source.amazon-ebs.packer-ami-rachit"
    ]

     provisioner "shell" {

     inline = [
      "sleep 30",
      "sudo apt update -y",
      "sudo apt upgrade -y",
      "sudo snap install node --classic",
      "sudo npm install -g npm@latest",
      "sudo npm install -g pm2@latest",
      "git clone https://github.com/rachit89/node-express-realworld-example-app.git",
      "cd node-express-realworld-example-app/",
      "sudo npm install",
      "sudo pm2 start app.js",

      ]
     }
}
