provider "aws" {
    region = "eu-north-1"
}

variable "cidr_blocks" {
    description = "cidr blocks"
    type = list(object({
      cidr_block =string
      name = string
    }))
}

resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
      "Name" = var.cidr_blocks[0].name
      "vpc_env" = "dev"
    }
}

resource "aws_subnet" "dev-subnet-1" { 
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = "eu-north-1a"
    tags = {
      "Name" = var.cidr_blocks[1].name
    }
}

output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}