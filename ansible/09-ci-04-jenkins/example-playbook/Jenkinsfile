pipeline {
    agent {
        label 'centos-01'
    }

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage("Git") {
            steps {
                git branch: 'main', credentialsId: '900c5069-ee77-4065-be4c-33643aea1430', url: 'https://github.com/sisipka/vector-role.git'
            }
        }
        stage("molecule"){
            steps {
                sh '''pip install molecule-docker molecule-podman
molecule --version
molecule test'''
            }
        }
    }
}
