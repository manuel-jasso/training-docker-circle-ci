#!/bin/bash
docker build -t manueljasso/sample-node .
docker push manueljasso/sample-node

ssh deploy@159.203.127.59 << EOF
docker pull manueljasso/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi manueljasso/sample-node:current || true
docker tag manueljasso/sample-node:latest manueljasso/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 manueljasso/sample-node:current
EOF
