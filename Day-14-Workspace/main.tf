resource "aws_key_pair" "name" {
  key_name   = "test-key1"
  public_key = file("~/.ssh/id_ed25519.pub") # Ensure you have a public key at this path
}
#if we want to create different workspaces then we can use the following command:
#! terraform workspace new <workspace_name>
# If we want to switch to a different workspace, we can use the following command:
#! terraform workspace select <workspace_name>
# if we have 3 workspaces, then 3 statefiles will be created in the .terraform directory
# workspace is worked in you laptop only, not in remote.


#A Terraform workspace is a way to manage multiple copies of the same infrastructure (e.g., dev, test, prod) using the same codebase.
# Subcommands:
#     delete    Delete a workspace
#     list      List Workspaces
#     new       Create a new workspace
#     select    Select a workspace
#     show      Show the name of the current workspace
# terraform workspace select dev
# terraform workspace list
