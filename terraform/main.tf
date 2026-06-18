
module "catalogue_instance" {
  source  = "git::https://github.com/jana-tech0/terraform-modules.git//modules/ec2"
  ami = data.aws_ami.password_enabled.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]
  
  subnet_id = element(split(",",data.aws_ssm_parameter.private_subnet_ids.value), 0)
  //iam_instance_profile = "catalogue-profile-${var.env}"
  //user_data = file("catalogue.sh")
  tags = merge(
    {
        Name = "catalogue-${var.env}-ami"
    },
    var.common_tags
  )
}

resource "null_resource" "cluster" {
  
  triggers = {
    instance_id = module.catalogue_instance.id
  }

 
  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = module.catalogue_instance.private_ip
  }

  
  provisioner "file" {
    source      = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
  }

  provisioner "remote-exec" {
   
    inline = [
      "chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh ${var.app_version} ${var.env}"
    ]
  }
}