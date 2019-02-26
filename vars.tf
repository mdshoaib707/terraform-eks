variable "cluster-name" {
  default = "demo-cluster"
  type = "string"
}

variable "eks-version" {
  default = "1.11"
}

variable "eks-worker-version" {
  default = "amazon-eks-node-1.11-v*"
}
