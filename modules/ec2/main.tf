#INSTANCES
resource "aws_instance" "sub1-pub" {
    ami                     = lookup(var.ec2-properties, "ami")
    instance_type           = lookup(var.ec2-properties, "instance_type")
    key_name                = lookup(var.ec2-properties, "key_name")
    subnet_id               = var.subnet1_id
    vpc_security_group_ids  = [aws_security_group.dep4-sg.id]

    user_data               = "${file("deploy-app.sh")}"

    tags                    = {"Name" = "sub1-pub-server"}
}

resource "aws_instance" "sub2-pub" {
    ami                     = lookup(var.ec2-properties, "ami")
    instance_type           = lookup(var.ec2-properties, "instance_type")
    key_name                = lookup(var.ec2-properties, "key_name")
    subnet_id               = var.subnet2_id
    vpc_security_group_ids  = [aws_security_group.dep4-sg.id]

    user_data               = "${file("deploy-app.sh")}"

    tags                    = {"Name" = "sub2-pub-server"}
}