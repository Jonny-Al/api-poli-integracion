pipeline {
    agent any
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Jonny-Al/api-poli-integracion']]])
                sh "mvn clean package"
                sh 'mvn clean install'
            }
        }
        stage('Build docker image'){
            echo "Contruir"
            steps{
                script{
                    sh 'docker build -t repository-app-day:1.0.0.0-SNAPSHOT .'
                }
            }
        }
        stage('Push image to Hub'){
            echo "Hacer push a la imagen"
             steps{
                script{
                        withCredentials([string(credentialsId: '123456', variable: '123456')]) {
                        sh 'docker login -u javatechie -p 123456'
                        sh 'docker push poli/integration-api-rest'
                    }
                }
            }
        }
        stage('Execute comands'){
            echo "Ejecutar el sh en repo comandos.sh"
             steps{
                script{
                        sh "./comandos.sh"
                    }
                }
            }
        }
}