A Docker Image of pre-commit for Python Project

## Usage
```
cd <python project>
docker run --pull always -v $PWD:/app ghcr.io/acefei/python3-precommit-docker:main [*.py]
# find more usage as follows
```

You can also build the docker image by manual with this repo.
1. Build docker image by running `docker compose build`
2. Run pre-commit under the python repo
```
cd <a git repo of python project>
# run pre-commit with files
docker run -v $PWD:/app pre-commit [specific filenames, if empty, run with all files under the current folder]

# or run minimal check
docker run -v $PWD:/app -e CONF_TARGET=ultra pre-commit

# or run with latest pre-commit hooks
docker run -v $PWD:/app -e UPDATE=true pre-commit
```
