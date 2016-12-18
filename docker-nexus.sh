docker run --detach \
    --publish 8081:8081 \
    --name nexus \
    --volume /app/list/data/nexus:/sonatype-work \
    sonatype/nexus3
