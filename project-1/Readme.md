# Terraform Code to generate an ssh key pairs and create a yaml file with a template .tpl file to store values of the keys for server ssh.

1. First to create the SSH Keys we will use the 'tls_private_key' resource to generate a new RSA key pair, and then use the 'tls_public_key' data source to extract the public key from the private key.

2. We will use the 'local_file' resource in the local provider in Terraform to create a YAML file from a template file, you can define a local_file resource and use the content attribute to render the template and write the resulting YAML content to a file.

3. To format YAML output to 4 indents with Terraform when rendering a YAML template file, you can use the templatefile function to render the template and then use the indent function to add 4 spaces of indentation to each line.

# NOTE: we will be using terraform providers below:
#  terraform  >= 0.14.5
# local >= 2.0.0
# tls >= 3.0.0