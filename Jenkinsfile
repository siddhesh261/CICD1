pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'What action should Terraform take?')
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent any
    stages {
        stage('Checkout Code') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/yeshwanthlm/Terraform-Jenkins.git"
                        }
                    }
                }
            }

        stage('Terraform Plan') {
            steps {
                sh 'pwd;cd terraform/ ; terraform init'
                sh "pwd;cd terraform/ ; terraform plan -out tfplan"
                sh 'pwd;cd terraform/ ; terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }
           steps {
               script {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }
        stage('Terraform Execution') {
            steps {
                if (params.ACTION == 'apply') {
                  sh "pwd;cd terraform/ ; terraform ${params.ACTION} -input=false tfplan"
                } else {
                  sh "pwd;cd terraform/ ; terraform ${params.ACTION} --auto-approve"
                }
            }
        }
    }
  }
