node {
   def version
   stage('Preparation') {
        version = sh(script: 'git rev-list --all --count', returnStdout: true).trim()
        echo "Building version ${version}"
        sh 'docker pull nginx:stable-alpine'
   }
   stage('Build') {
        echo "Building version ${version}"
        sh "docker build -t taimos/redirector:${version} ."
   }
   stage('Test') {
        def container = sh(script: "docker run -d -P taimos/redirector:${version}", returnStdout: true).trim()
        def port = sh(script: "docker inspect -f '{{ (index (index .NetworkSettings.Ports \"80/tcp\") 0).HostPort }}' ${container}", returnStdout: true).trim()

        sh "./test.sh ${port}"

        sh "docker stop ${container}"
        sh "docker rm ${container}"
   }
   stage('Publish') {
        sh "docker tag taimos/redirector:${version} taimos/redirector:latest"
        sh "docker push taimos/redirector:${version}"
        sh "docker push taimos/redirector:latest"
   }
}