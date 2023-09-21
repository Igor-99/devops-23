node("centos-01"){
    if (env.PROD_RUN == "true") {
        stage("Run playbook") {
                git credentialsId: '900c5069-ee77-4065-be4c-33643aea1430', url: 'https://github.com/sisipka/example-playbook.git'
                sh 'ansible-playbook -i inventory/prod.yml site.yml'
        }
    }
    else {
        stage("Run playbook") {
                git credentialsId: '900c5069-ee77-4065-be4c-33643aea1430', url: 'https://github.com/sisipka/example-playbook.git'
                sh 'ansible-playbook -i inventory/prod.yml site.yml --check --diff'
        }
        
    }
}
