FROM python:slim

RUN apt-get update && \
    apt-get install --no-install-recommends -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade --no-cache-dir pip pre-commit

COPY . /config

WORKDIR /app
COPY .pre-commit-config.yaml .
SHELL ["/bin/bash", "-c"]
ENV PYRIGHT_PYTHON_FORCE_VERSION=latest
RUN git init . && \
    pre-commit install-hooks && \
    eval "\$(find ~/.cache/pre-commit | grep 'bin/pyright\$') --help"

ENTRYPOINT [ "sh", "/config/entrypoint.sh" ]
