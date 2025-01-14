####################################
# AWS Resources to spin up cluster
####################################

# # Create a VPC for the EKS Cluster
# resource "aws_vpc" "eks_vpc" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = "eks-vpc"
#   }
# }

# # Create subnets
# resource "aws_subnet" "eks_subnet_a" {
#   vpc_id            = aws_vpc.eks_vpc.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "eks-subnet-a"
#   }
# }

# resource "aws_subnet" "eks_subnet_b" {
#   vpc_id            = aws_vpc.eks_vpc.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = "us-east-1b"

#   tags = {
#     Name = "eks-subnet-b"
#   }
# }

# # Create an EKS Cluster
# resource "aws_eks_cluster" "my_eks_cluster" {
#   name     = "my-eks-cluster"
#   role_arn = aws_iam_role.eks_cluster_role.arn
#   vpc_config {
#     subnet_ids = [
#       aws_subnet.eks_subnet_a.id,
#       aws_subnet.eks_subnet_b.id,
#     ]
#   }

#   depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
# }

# # Create IAM role for EKS Cluster
# resource "aws_iam_role" "eks_cluster_role" {
#   name = "eks_cluster_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#         Effect = "Allow"
#         Sid    = ""
#       },
#     ]
#   })
# }

# # Attach the EKS Cluster policy to the IAM role
# resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.eks_cluster_role.name
# }

# # Create IAM role for EKS Worker Nodes
# resource "aws_iam_role" "eks_node_role" {
#   name = "eks_node_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Effect = "Allow"
#         Sid    = ""
#       },
#     ]
#   })
# }

# # Attach the EKS Node policy to the IAM role
# resource "aws_iam_role_policy_attachment" "eks_node_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.eks_node_role.name
# }

# resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.eks_node_role.name
# }

# # Output the cluster name
# output "cluster_name" {
#   value = aws_eks_cluster.my_eks_cluster.name
# }