terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

variable "public_key_path" {
  type        = string
  description = "Caminho da chave pública"
  default     = "~/.ssh/id_rsa.pub"
}

variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
}
resource "aws_key_pair" "main" {
  key_name   = "jewelry-key"
  public_key = file(var.public_key_path)
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
    description = "acesso de todos"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jewelry_vm" {
  ami                         = "ami-0fc5d935ebf8bc3bc"
  instance_type               = "t2.micro"
  monitoring                   = true
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

    cd /root
    rm -rf proway-docker/
    git clone https://github.com/dartanghan/proway-docker.git
    cd proway-docker/modulo7-iac_tooling

    docker build -t jewelry-app .
    docker run -d -p 8080:80 jewelry-app
  EOF

  tags = {
  Name        = "jewelry_vm"
  Environment = "dev"
  Owner       = "Pedro"
  }
}

output "vm_public_ip" {
  value = aws_instance.jewelry_vm.public_ip
}

output "app_url" {
  value     = "http://${aws_instance.jewelry_vm.public_ip}:8080"
  sensitive = true
}