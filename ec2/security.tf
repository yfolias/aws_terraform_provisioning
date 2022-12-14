resource "aws_security_group" "ingress-all-test" {
    name = "allow-remote-connections"
    vpc_id = aws_vpc.my_vpc.id

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        
        from_port = var.remote_port
        to_port = var.remote_port
        protocol = "tcp"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
