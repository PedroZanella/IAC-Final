terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "main" {
  key_name   = "jewelry-key"
  public_key = file("C:\\Users\\pedro_huas\\.ssh\\id_rsa.pub") 
}

resource "aws_security_group" "jewelry_sg" {
  name        = "jewelry-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = "vpc-06786ee7f7a163059"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jewelry_vm" {
  ami                         = "ami-0fc5d935ebf8bc3bc"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-07f25c27c4f87bbcf"
  key_name                    = aws_key_pair.main.key_name
  vpc_security_group_ids      = [aws_security_group.jewelry_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io git
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ubuntu

    docker container stop jewelry-app 2> /dev/null

    cd /home/ubuntu
    rm -rf proway-docker/
    git clone https://github.com/dartanghan/proway-docker.git
    cd proway-docker/modulo7-iac_tooling

    docker build -t jewelry-app .
    docker run -d -p 8080:80 jewelry-app
  EOF

  tags = {
    Name = "jewelry-vm"
  }
}

output "vm_public_ip" {
  value = aws_instance.jewelry_vm.public_ip
}

output "app_url" {
  value = "http://${aws_instance.jewelry_vm.public_ip}:8080"
}