output "aws_account_id" {
  description = "AWS account mà Terraform đang thao tác"
  value       = data.aws_caller_identity.current.account_id
}

output "hello_parameter_name" {
  description = "Tên SSM parameter vừa tạo"
  value       = aws_ssm_parameter.hello.name
}
