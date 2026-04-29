variable "key_pair_name" {
  type = string
}

variable "buildkite_agent_token" {
  type      = string
  sensitive = true
}
