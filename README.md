# gcloud-and-docker

Docker container with docker + gcloud + curl.

Used mainly for CI jobs where I want to run smoke tests against GCP stuff using built docker containers earlier in the pipeline.

## Usage

### Build for Docker Hub

It's hooked up to their auto-build setup. Use as follows:

git tag -a 1.0 -m "something that describes the change"
git push origin 1.0

### Base Image

Build base image with `docker build -t gcloud-and-docker .` (replace with your own tag as needed).

You can test this locally with something like: `docker run --rm -it -v /path/to/mount:/build /bin/bash`.
