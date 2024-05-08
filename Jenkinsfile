pipeline {
    agent any

    parameters {
        string(name: 'GIT_BRANCH', defaultValue: 'master', description: 'Branch to build')
        string(name: 'GIT_URL', defaultValue: 'https://github.com/bucky2929/php-website.git', description: 'Git repository URL')
        string(name: 'SSH_SERVER', defaultValue: 'php-server-prod', description: 'SSH Server for deployment')
        string(name: 'REMOTE_DIR', defaultValue: '/var/www/html', description: 'Remote directory for deployment')
        string(name: 'APPROVER_EMAIL', defaultValue: 'approver@example.com', description: 'Email address for deployment approval')
    }

    stages {
        stage('Manual Approval') {
            steps {
                mail(to: "${params.APPROVER_EMAIL}",
                     subject: "Deployment Approval Required",
                     body: "Please approve the deployment by visiting: ${env.BUILD_URL}input/"
                )
                input(message: "Approval required for deployment. Click 'Proceed' to continue.", submitterParameter: 'APPROVER_EMAIL')
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: "${params.GIT_BRANCH}",
                    url: "${params.GIT_URL}"
            }
        }

        stage('Deploy to Production') {
            steps {
                script {
                    sshPublisher(
                        publishers: [
                            sshPublisherDesc(
                                configName: "${params.SSH_SERVER}",  // Uses variable for SSH server name
                                verbose: true,
                                transfers: [
                                    sshTransfer(
                                        sourceFiles: '**/*',
                                        removePrefix: '',
                                        remoteDirectory: "${params.REMOTE_DIR}"  // Uses variable for remote directory
                                    )
                                ]
                            )
                        ]
                    )
                }
            }
        }

        stage('Post-Deployment') {
            steps {
                echo "Deployment complete."
            }
        }
    }
}
