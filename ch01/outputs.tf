#Define output 
output "Jenkins-instance-id" {
  value       = aws_instance.jenkins.id
  description = "Jenkins instance ID number"
}

output "Jenkins-public-ip" {
  value       = aws_instance.jenkins.public_ip
  description = "Jenkins public IP of the web server"
}

output "Jenkins-bucket-name" {
  value       = aws_s3_bucket.jenkins-artifacts.id
  description = "Name of the Jenkins S3 bucket"
}