FROM python:3.11-bullseye AS base
RUN apt update -y  && rm -rf /var/cache/*

FROM base AS build-pre-commit
RUN apt install -y git && pip install pre-commit --no-cache-dir
CMD sh -c "pre-commit autoupdate && pre-commit run --all-files | tee pre-commit.log"
