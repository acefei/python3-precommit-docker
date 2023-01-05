#!/bin/bash
set -eu
[ "${DEBUG:-}" = "true" ] && set -x

precommit=.pre-commit-config.yaml
pyproject=pyproject.toml
is_git_repo=false
[ -d ".git" ] && is_git_repo=true

cleanup() {
    [ -h "$precommit" ] && rm "$precommit"
    [ -h "$pyproject" ] && rm "$pyproject"
    [ "$is_git_repo" = "false" ] && rm -rf .git
}
trap cleanup EXIT

prepare() {
    {
        if [ "$is_git_repo" = "true" ];then
            git config --global --add safe.directory /app
        else
            git init
            git config --global --add safe.directory /app
            git add -A
        fi
    # hidden output above
    } >/dev/null 2>&1

    # To set ENV in docker-compose.yaml to switch pre-commit-config.yaml
    [ -f "$precommit" ] || ln -s /config/.pre-commit-config.yaml "$precommit"
    [ -f "$pyproject" ] || ln -s /config/pyproject.toml.${CONF_TARGET:-min} "$pyproject"
}

pre_commit() {
    [ "${UPDATE:-}" = "true" ] && pre-commit autoupdate
    # Avoid dirtying the original director when docker run -v $PWD:/app
    export MYPY_CACHE_DIR=/tmp
    export RUFF_CACHE_DIR=/tmp
    if [ "$#" -gt 0  ]; then
        pre-commit run --files "$@"
    else
        pre-commit run --all-files
    fi
}

prepare
pre_commit "$@"
