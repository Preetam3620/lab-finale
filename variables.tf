variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "invoice-processing"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default = "value"
}

variable "alb_arn_suffix" {
  description = "ARN suffix of the ALB"
  type        = string
  default = "value"
}

variable "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  type        = string
  default = "value"
}
