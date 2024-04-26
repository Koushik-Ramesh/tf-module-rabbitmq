# Reads the information from remote state file
data "terraform_remote_state" "vpc" {
   backend = "s3"
   config = {
       bucket = "koushik-bucket"
      key = "vpc/${var.ENV}/terraform.tfstate"
       region = "us-east-1"
   }
 }

# DataDource to fetch the info of AMI
data "aws_ami" "ami" {
    most_recent      = true
    name_regex       = "b55 - ansible-lab-image"
    owners           = ["self"]
}

 # Fetches the information from secret manager
data "aws_secretsmanager_secret" "secret" {
    name = "Robot/Secrets"
}

# Fetches the secrets version from the above server
data "aws_secretsmanager_secret_version" "secret_version" {
    secret_id = data.aws_secretsmanager_secret.secret.id
}

