# Create a VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.16.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
}

resource "aws_internet_gateway" "my_gw" {
    vpc_id = aws_vpc.my_vpc.id
}

resource "aws_subnet" "my_subnet" {
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block        = "10.16.10.0/24"
    availability_zone = var.availability_zone
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_gw.id
    }
}

resource "aws_route_table_association" "subnet-association" {
    subnet_id      = aws_subnet.my_subnet.id
    route_table_id = aws_route_table.route_table.id
}

resource "aws_key_pair" "my_key" {
    key_name   = var.ssh_key_name
    public_key = var.public_key
}

resource "aws_instance" "instance" {
    ami                             = var.ami_id
    instance_type                   = var.instance_type
    key_name                        = aws_key_pair.my_key.key_name
    associate_public_ip_address     = true
    security_groups                 = [aws_security_group.ingress-all-test.id]
    subnet_id                       = aws_subnet.my_subnet.id
    user_data                       = templatefile("user-data/${terraform.workspace}-script.tftpl", { instance_name = "${terraform.workspace}-${var.instance_name}" , password = "test123" })
    
    tags = {
        Name = "${terraform.workspace}-${var.instance_name}"
    }
}

output "instance_ip" {
    description = "The public ip for ssh access"
    value       = aws_instance.instance.public_ip
}