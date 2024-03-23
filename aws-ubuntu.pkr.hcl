packer {
    required_plugins {
        amazon = {
            source  = "github.com/hashicorp/amazon"
            version = "~> 1"
        }

    }
}

source "amazon-ebs" "builder_name" {
    ami_name            =   "My_First_Packer_Image"
    insatnce_type       =   "t2.micro"
    region              =   "us-east-1"

    source_ami          =   "ami-055744c75048d8296"

    ssh_username        =   "ubuntu"

    // access_key          =   "XXXX"
    // secret_access_key   =   "XXXX"
    
}

build {
    name        =   "my_first_build"
    sources     =   ["source.amazon-ebs.builder_name"] 

    provisioner "shell" {
        inline  =   [
            "sudo apt update",
            "sudo apt install nginx -y",
            "sudo systemctl enable nginx",
            "sudo systemctl start nginx",
            "sudo ufw allow proto tcp from any to any port 22,80,443",
            "echo 'y' | sudo ufw enable"
        ]
    }

    // post-processor "vagrant" {}
    // post-processor "compress" {}
}

