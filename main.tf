terraform {
  backend "s3" {
    bucket         = "desafio-tecnico-s3" 
    key            = "terraform/state/terraform.tfstate" 
    region         = "us-east-1"                
    encrypt        = true                               
    dynamodb_table = "terraform-locks"                  
  }
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "s3" {
  source = "./modules/s3"
  bucket_name = "desafio-tecnico-s3"
}

module "ec2" {
  source = "./modules/ec2"
  ami_id          = "ami-0c02fb55956c7d316" 
  instance_type   = "t2.micro"
  public_subnet_id = module.vpc.public_subnets[0]
  security_group_ids = [module.vpc.sg_ec2]
  bucket_name     = module.s3.bucket_name
}

module "rds" {
  source = "./modules/rds"
  private_subnet_ids = module.vpc.private_subnets
  security_group_id  = module.vpc.sg_rds
  db_name            = "mydatabase"
  db_username        = var.rds_username
  db_password        = var.rds_password
}
