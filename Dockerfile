FROM r-base

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
  libxml2-dev libssl-dev libcurl4-openssl-dev libssh2-1-dev

ENV APP_DIR /src/app/

RUN mkdir -p $APP_DIR

COPY ./init.R ${APP_DIR}

WORKDIR ${APP_DIR}

RUN ["Rscript", "init.R"]

COPY . .