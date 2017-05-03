docker run --detach \
    --publish 8080:8080 --publish 50000:50000 \
    --volume /app/list/data/jenkins:/var/jenkins_home \
    --name jenkins \
    jenkins
