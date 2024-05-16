resource "aws_instance" "tf-instance" {
    ami = var.ami_id_value
    instance_type = "t2.micro"
    security_groups = [aws_security_group.tf-sg.id] 
    key_name = var.key_pair_value
    subnet_id = aws_subnet.tf-pub-sub.id
    depends_on = [ 
        aws_security_group.tf-sg
     ]
     tags = {
    Name = "tf-instance ${var.random_id}"
  }

  connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("./ec2/server.pem")
      #host = aws_instance.tf-insatnce.public_ip
      host = self.public_ip
  }
 provisioner "remote-exec" {
    inline = [
	  "sudo apt-get update",
      "sudo apt-get install nginx -y",
	  "sudo systemctl start nginx",
    ]
  }
}

