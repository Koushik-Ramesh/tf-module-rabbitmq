# Creates Security Group
resource "aws_security_group" "allows_rabbitmq" {
    name = "Roboshop-${var.ENV}-rabbitmq-sg"
    description = "allow only rabbitmq traffic"
    vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

 
    ingress {
        description = "SSH from VPC"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR , data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
    }

    ingress {
    description = "rabbitmq from VPC"
    from_port   = var.RABBITMQ_PORT_NUMBER
    to_port     = var.RABBITMQ_PORT_NUMBER
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
    }

    ingress {
    description = "rabbitmq from Default VPC"
    from_port   = var.RABBITMQ_PORT_NUMBER
    to_port     = var.RABBITMQ_PORT_NUMBER
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "roboshop-${var.ENV}-rabbitmq-sg"
    }
}
