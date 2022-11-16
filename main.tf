module "createVpc" {
  source    = "./modules/vpc"
  vpc-cidr  = var.vpc-cidr
  sub1-cidr = var.sub1-cidr
  sub2-cidr = var.sub2-cidr

}

module "createEC2" {
  source         = "./modules/ec2"
  vpc_id         = module.createVpc.vpc_id
  subnet1_id     = module.createVpc.subnet1_id
  subnet2_id     = module.createVpc.subnet2_id
  ec2-properties = var.ec2-properties
  depends_on = [
    module.createVpc
  ]
}

module "createALB" {
  source    = "./modules/alb"
  elb_sg_id = module.createEC2.elb_sg_id
  depends_on = [
    module.createEC2
  ]
}