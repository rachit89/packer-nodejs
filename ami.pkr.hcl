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
        "source.amazon-ebs.nodejs-packer-ami-rachit"
    ]

    "provisioners": [{
    "type": "shell",
    "inline": [
      "sleep 30",
      "sudo apt update -y",
      "sudo apt install nodejs -y",
      "curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash",
      "source ~/.bashrc",
      "nvm install 8",
      "npm install -g npm@latest",
      "sudo npm install -g pm2@latest",
      "git clone https://github.com/rachit89/node-express-realworld-example-app.git",
      "cd node-express-realworld-example-app/",
      "sudo npm install",
      "pm2 start app.js",
      "pm2 startup",
      "sudo env PATH=$PATH:/usr/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu",
      "pm2 save"
      
    ]
    }]
 }
}
