docker run --privileged --detach \
    --hostname gitlab.example.com \
    --publish 443:443 --publish 80:80 --publish 2223:22 \
    --name gitlab \
    --restart always \
    --volume /app/list/data/gitlab/config:/etc/gitlab \
    --volume /app/list/logs/gitlab:/var/log/gitlab \
    --volume /app/list/data/gitlab:/var/opt/gitlab \
    gitlab/gitlab-ce:latest
