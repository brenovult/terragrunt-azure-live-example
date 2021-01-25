# Alpine - https://hub.docker.com/_/node
FROM node:14-alpine3.12

# https://github.com/microsoft/azure-pipelines-agent/blob/master/docs/design/non-glibc-containers.md
RUN apk add --no-cache --virtual .pipeline-deps readline linux-pam \
  && apk add bash sudo shadow docker make \
  && apk del .pipeline-deps

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"

# CMD [ "node" ]
