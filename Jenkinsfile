#!/usr/bin/env groovy
pipeline {
    agent any 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = "us-east-1"
    }
    stages {
        stage('Create EKS Cluster') {
            steps {
                //
                script {
                    dir('terraform') {
                        sh "terraform init"
                        // sh "terraform apply --auto-approve"
                        sh "terraform destroy --auto-approve"
                    }
                } 
            }
        }
        stage('deploy socks-shop') {
            steps {
                // 
                script {
                    script {
                        dir('deploy/kubernetes') {
                            sh "aws eks update-kubeconfig --name myapp-eks-cluster"
                            sh "kubectl create namespace sock-shop"
                            sh "kubectl apply -f complete-demo.yaml"
                            sh "kubectl apply -f frontend_ingress.yaml"
                            sh "kubectl create -f staging_issuer.yaml"
                            sh "kubectl create -f prod_issuer.yaml"
                            // sh "kubectl create -f manifests-monitoring"
                            // sh "helm repo add prometheus-community https://prometheus-community.github.io/helm-charts"
                            // sh "helm install mongodb-exporter prometheus-community/prometheus-mongodb-exporter -f values.yaml"
                        }
                    }
                }
            }
        }
    }
}