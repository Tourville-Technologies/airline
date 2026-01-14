FROM eclipse-temurin:17-jdk-alpine AS base


# SHELL ["/bin/bash", "-c"]

# Install sbt directly from official Debian package (fast!)
# RUN apt-get update \
#     && apt-get upgrade --yes \
#     && apt-get install --yes curl unzip zip gnupg \
#     && echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list \
#     && echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list \
#     && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add \
#     && apt-get update \
#     && apt-get install --yes sbt \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/*

# Install dependencies and sbt - ALPINE
RUN apk add --no-cache bash curl tar gzip \
    && mkdir -p /usr/local/share \
    && curl -L "https://github.com/sbt/sbt/releases/download/v1.12.0/sbt-1.12.0.tgz" | tar -xz -C /usr/local/share \
    && ln -s /usr/local/share/sbt/bin/sbt /usr/local/bin/sbt

# Pre-download sbt launcher and dependencies (caching optimization)
WORKDIR /tmp
RUN sbt --allow-empty sbtVersion && rm -rf /tmp/*

FROM base

RUN addgroup airline \
    && adduser -S -G airline -h /home/airline airline
# && adduser airline sudo \
# && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir -p /home/airline/bin \
    && chown -vR airline:airline /home/airline \
    && chmod -vR 755 /home/airline

COPY --chown=airline:airline airline-data /home/airline/airline/airline-data
COPY --chown=airline:airline airline-web /home/airline/airline/airline-web
COPY --chown=airline:airline scripts /home/airline/airline/scripts
COPY --chown=airline:airline sbt-launch.jar /home/airline/airline/sbt-launch.jar

USER airline
ENV PATH="$PATH:/home/airline/bin"

WORKDIR /home/airline

ENTRYPOINT ["tail", "-f", "/dev/null"]