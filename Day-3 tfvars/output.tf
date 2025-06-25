output "public_ip" {
    value = aws_instance.name.public_ip
}
output "private_ip" {
    value = aws_instance.name.private_ip
    sensitive = true
    # terraform output private_ip #command to show sensitive content
}
output "subnet" {
    value = aws_instance.name.subnet_id
  
}