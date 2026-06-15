module "catalogue_instance" {
  source = "git::https://github.com/jana-tech0/terraform-modules.git"
  ami = "ami-0f38e4c6b228846b1"

  instance_type = "t3.medium"
  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]
  # it should be in Roboshop DB subnet
  subnet_id = split(data.aws_ssm_parameter.private_subnet_ids,0)
  user_data = file("catalogue.sh")
  tags = merge(
    {     
        Name = "Catalogue-DEV-AMI"
    },
    var.common_tags
  )
}
