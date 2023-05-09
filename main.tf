provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "k8s-master" {
  ami           = "ami-0817d428a6fb68645"
  instance_type = "t2.micro"

  key_name      = "my-key"  # Substitua "my-key" pelo nome da sua chave SSH no console da AWS

  tags = {
    Name = "k8s-master"
  }
}

resource "aws_security_group" "k8s-master-sg" {
  name_prefix = "k8s-master-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
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

resource "aws_key_pair" "k8s-master-key" {
  key_name   = "k8s-master-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "bucket-caf-porjeto"  
  
  tags = {
    Name = "bucket-caf-porjeto"
  }
}
