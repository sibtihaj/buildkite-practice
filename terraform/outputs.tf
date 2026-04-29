output "instance_id" {
  value = aws_instance.buildkite_agent.id
}

output "public_ip" {
  value = aws_instance.buildkite_agent.public_ip
}
