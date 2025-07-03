
resource "aws_key_pair" "example" {
  key_name   = "task" # Replace with your desired key name
  public_key = file("~/.ssh/id_ed25519.pub")


}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name # Your EC2 keypair name

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_ed25519")
      host        = self.public_ip
    }
  }
}
