resource "aws_instance" "chef-node" {

  ami = "ami-01419b804382064e4"
  instance_type = "t2.micro"
  key_name = "mykey-london"

  vpc_security_group_ids = ["${aws_security_group.chef-security.id}"]

  # Run chef client to this particular instance 
  provisioner "chef" {
    environment = "_default"
    run_list = ["firstcookbook::default"]
    node_name = "webserver123"
    server_url = "https://api.chef.io/organizations/cheforg909"
    recreate_client = true
    user_name = "mdshoaib707"
    user_key = "${file("../mdshoaib707.pem")}"

  }

  # Use the following key to ssh to the instance
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file("/Users/shoaib/Documents/myfolder/terraform/chef-terraform/mykey-london.pem")}"
    host = "${aws_instance.chef-node.public_ip}"
  }

  depends_on = [
    "aws_security_group.chef-security"
  ]

  tags {
    "name" = "chef-node"
  }

}


resource "aws_security_group" "chef-security" {
  description = "chef security group"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow-ssh-chef"
  }

}
