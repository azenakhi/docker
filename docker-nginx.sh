docker run --detach \
    --hostname registry.sws.group.gca \
    --publish 80:80 \
    --name nginx \
    --volume /Users/azenakhi/Downloads/data/nginx/nginx.conf:/etc/nginx/conf.d/default.conf:rw \
    --volume /Users/azenakhi/Downloads/data/nginx/nginx-silca.conf:/etc/nginx/conf.d/registry-silca.conf:rw \
    --restart unless-stopped \
    --network intranet \
    nginx
