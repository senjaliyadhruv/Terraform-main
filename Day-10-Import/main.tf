# terraform import aws_instance.my_instance <instance_id>
#if we want to import an instance from AWS console, we need to run this command in the terminal. 
# thereafter, we need to copy the ami and instance type from statefile and paste it in the resource block in main.tf file.
# after that, we can run terraform plan and apply to see the changes.
resource "aws_instance" "my_instance" {

}
