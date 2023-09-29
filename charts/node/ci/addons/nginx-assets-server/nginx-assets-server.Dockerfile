FROM docker.io/nginx:1.25.2-alpine

COPY assets/tick_v9-chain-backup.tar.gz assets/rococo-local.json /usr/share/nginx/html/
RUN tar -xzf /usr/share/nginx/html/tick_v9-chain-backup.tar.gz -C /usr/share/nginx/html/ && \
    rm /usr/share/nginx/html/tick_v9-chain-backup.tar.gz
