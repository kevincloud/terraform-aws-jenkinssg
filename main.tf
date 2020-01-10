variable "aws_access_key" { }
variable "aws_secret_key" { }
variable "aws_region" { }

provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = var.aws_region
}

data "aws_vpc" "primary-vpc" {
    default = true
}

resource "aws_security_group" "jenkins-server-sg" {
    name = "jenkins-server-sg-1"
    description = "Jenkins server security group"
    vpc_id = data.aws_vpc.primary-vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
       from_port = 8080
       to_port = 8080
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
       from_port = 9000
       to_port = 9000
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "id" {
    value = aws_security_group.jenkins-server-sg.id
}
