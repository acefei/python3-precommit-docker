A Docker Image of pre-commit for Python Project

## Usage
1. Build docker image by running `docker compose build`
2. Run pre-commit under python repo
```
cd <a git repo of python project>
# run pre-commit with files
docker run -v $PWD:/app pre-commit [specific filenames, if empty, run with all files under the current folder]

# or run minimal check
docker run -v $PWD:/app -e CONF_TARGET=ultra pre-commit

# or run with latest pre-commit hooks
docker run -v $PWD:/app -e UPDATE=true pre-commit
```
