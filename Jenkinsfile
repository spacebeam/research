pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/spacebeam/research.git'
            }
        }

        stage('Build') {
            steps {
                sh 'cd web/luerl.org && nikola build'
            }
        }

        stage('Test (Optional)') {
            steps {
                sh 'cd web/luerl.org && nikola serve &'
                // Add steps to automate tests against your running local server
                sh 'kill %1' // Stop the server
            }
        }

        stage('Deploy') {
            steps {
                // Add your deployment steps here. Examples:
                // - rsync to your web server
                // - Use a plugin like Publish Over SSH
                // - Push to a different Git repository (GitHub Pages, etc.)
                sh 'echo "Deployment steps go here."'
            }
        }
    }
}
