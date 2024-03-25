source "amazon-ebs" "builder_name" {
    ami_name            =   "AWS-Docker-Image"
    instance_type       =   "t2.micro"
    region              =   "us-east-1"

    source_ami          =   "ami-080e1f13689e07408"
    // source_ami          =   "ami-055744c75048d8296"

    ssh_username        =   "ubuntu"

    // access_key          =   "XXXX"
    // secret_access_key   =   "XXXX"
    
}

build {
    name        =   "aws-docker"
    sources     =   ["source.amazon-ebs.builder_name"] 

    provisioner "shell" {
        inline  =   [
            "sudo apt-get -y update",
            "sudo apt-get -y install ca-certificates curl",
            "sudo install -m 0755 -d /etc/apt/keyrings",
            "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc",
            "sudo chmod a+r /etc/apt/keyrings/docker.asc",
            "echo 'deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \\",
            "$( . /etc/os-release && echo \"$VERSION_CODENAME\") stable' | \\",
            "sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
            "sudo apt-get -y update",
            "sudo apt -y install snapd",
            "sudo snap -y install docker",
            "sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
            "sudo docker --version",
            "sudo groupadd docker",
            "sudo usermod -aG docker ubuntu",
            "sudo chown $USER:docker /var/run/docker.sock",
            "sudo chmod 660 /var/run/docker.sock",
            "exit",
            "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
            "unzip awscliv2.zip",
            "sudo ./aws/install",
            "./aws/install -i /usr/local/aws-cli -b /usr/local/bin",
            "aws --version",
            "sudo reboot"
        ]
    }

}

