provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

module "s3" {
  source = "./modules/s3"
  bucket_prefix = "my-app-files-bucket"
}

module "fsx" {
  source = "./modules/fsx"

  subnet_id         = module.vpc.subnet_id
  vpc_id            = module.vpc.vpc_id
  security_cidr     = module.vpc.vpc_cidr
}
