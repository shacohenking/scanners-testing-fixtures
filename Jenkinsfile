pipeline {
    agent any
    triggers { cron('H/10 * * * *') }
    
    // You must add this block to "load" a secret
    environment {
        // 'my-cred-id' must exist in Manage Jenkins > Credentials
        MY_PASSWORD = credentials('my-cred-id') 
    }

    stages {
        stage('Secure Work') {
            steps {
                // Jenkins will mask the actual output with ****
                sh 'echo "My password is $MY_PASSWORD"'
                sh 'echo "access_key: AKIARPIT7QCJZ5BR553U"'
                sh 'echo "secret_key: DSnPnbAH1QwEu+utk4ZWO/c1KlcYT4/1AgaJ5HLXL"'
            }
        }
    }
}
