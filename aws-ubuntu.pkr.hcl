source "amazon-ebs" "builder_name" {
    ami_name            =   "My_First_Packer_Image"
    instance_type       =   "t2.micro"
    region              =   "us-east-1"

    source_ami          =   "ami-080e1f13689e07408"
    // source_ami          =   "ami-055744c75048d8296"

    ssh_username        =   "ubuntu"

    // access_key          =   "XXXX"
    // secret_access_key   =   "XXXX"
    
}

build {
    name        =   "my_first_build"
    sources     =   ["source.amazon-ebs.builder_name"] 

    provisioner "shell" {
        inline  =   [
            "sudo apt install nginx -y",
            "sudo systemctl enable nginx",
            "sudo systemctl start nginx",
            "sudo ufw allow proto tcp from any to any port 22,80,443",
            "echo 'y' | sudo ufw enable"
        ]
    }

}

