data "aws_caller_identity" "current" {}

resource "aws_ssm_parameter" "hello" {
  name  = "/terra-cloud-lab/hello"
  type  = "String"
  tier  = "Standard"
  value = "Hello, World!"

  tags = {
    Project = "terra-cloud-lab"
  }
}
