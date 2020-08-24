/* aws provider
*/
provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

# Define VPC 

resource "aws_vpc" "tfvpc" {
   cidr_block = "10.0.0.0/21"
   instance_tenancy = "default" 
   tags = {
       Name = "main"
   }
}

#internet gateway for the VPC
resource "aws_internet_gateway" "maingw" {
    vpc_id = aws_vpc.tfvpc.id
    tags = {
        Name = "terraformgateway"
    }
}

#create subnet for the vpc
#public subnet

resource "aws_subnet" "terraformpublicsubnet" {
    vpc_id = aws_vpc.tfvpc.id
    cidr_block = "10.0.1.0/25"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = "true"
    tags = {
        name = "tfpublicsubnet"
    }
}

##private subnet

resource "aws_subnet" "terraformprivatesubnet" {
    vpc_id = aws_vpc.tfvpc.id
    cidr_block = "10.0.2.0/25"
    availability_zone = "us-east-1b"
     map_public_ip_on_launch = "false"
    tags = {
        name = "tfprivatesubnet"
    }
}
 
#routetable

resource "aws_route_table" "terraformroutetable"{
    vpc_id = aws_vpc.tfvpc.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.maingw.id
    }
    tags = {
        Name = "tfpublicroutetable"
    }

}

#attach a public subnet to the route
resource "aws_route_table_association" "vpc_public_sn_rt_assn" {
    subnet_id = aws_subnet.terraformpublicsubnet.id
    route_table_id = aws_route_table.terraformroutetable.id
}

#security groups

resource "aws_security_group" "terraformsg" {
    name = "terraformsg"
    description = "created with terraform"
    vpc_id = aws_vpc.tfvpc.id

    
    tags = {
        Name = "terrsg"
    }

}

resource "aws_security_group_rule" "ingress1" {
    security_group_id = aws_security_group.terraformsg.id
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
}

resource "aws_security_group_rule" "ingress2" {
    security_group_id = aws_security_group.terraformsg.id
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
}

resource "aws_security_group_rule" "ingress3" {
    security_group_id = aws_security_group.terraformsg.id
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
}




   

    
