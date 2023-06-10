pipeline {
    environment {
        registry = "devteam4social/login"
        registryCredential = 'dockercred'
        dockerImage = ''
    }
    agent any
     tools {
        jdk 'java_home'
        maven 'maven_home' 
    }
    triggers { pollSCM('H/2 * * * *') }
    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')

        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')

        booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')

        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')

        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    }

    stages {
        stage('checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/devteam4social/webapplication.git']])
            }
        }
        stage('CQ') {
            steps {
                echo 'cheking cq'
            }
        }
        stage('build') {
            steps {
                sh """
                mvn clean install
                """
            }
        }
        stage('package') {
            steps {
                echo 'am packaging'
            }
        }
        stage('image creation') {
            steps {
                echo 'am creating image'
            }
        }
        stage('Building image') {
          steps{
            script {
              dockerImage = docker.build registry + ":$BUILD_NUMBER"
            }
          }
        }
        stage('Deploy Image') {
          steps{
            script {
              docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
              }
            }
          }
        }
        stage('Remove Unused docker image') {
          steps{
            sh "docker rmi $registry:$BUILD_NUMBER"
          }
        }
        stage('deplpoyment') {
            steps {
                echo 'am deploying'
            }
        }
    }
    
    post { 
        always { 
            cleanWs()
        }
    }
}
