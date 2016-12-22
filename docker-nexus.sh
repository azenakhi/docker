docker run --detach \
    --publish 8081:8081 \
    --publish 18444:18444 \
    --publish 18445:18445 \
    --name nexus \
    --volume /Users/azenakhi/Downloads/data/nexus:/nexus-data \
    --restart unless-stopped \
    --network intranet \
    sonatype/nexus3




cockpit portainer