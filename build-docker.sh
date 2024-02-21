#!/usr/bin/env bash

# Initialize a variable to control whether to push to Docker Hub
PUSH_TO_DOCKERHUB=false

# Parse command-line options
while getopts "p" opt; do
    case ${opt} in
    p)
        # If the -p option is provided, set PUSH_TO_DOCKERHUB to true
        PUSH_TO_DOCKERHUB=true
        ;;
    \?)
        # If an invalid option is provided, print an error message and exit
        echo "Invalid option: -$OPTARG" 1>&2
        exit 1
        ;;
    esac
done

# Check if the SYSDIG_CLI_VERSION environment variable is set
if [ -z "${SYSDIG_CLI_VERSION}" ]; then
    echo "SYSDIG_CLI_VERSION is not set. Set the SYSDIG_CLI_VERSION environment variable and try again."
    exit 1
fi

# Build the Docker image and tag it with the version number
docker build -t sysdig-cli-scanner:${SYSDIG_CLI_VERSION} .
# Tag the image with the "latest" tag
docker tag sysdig-cli-scanner:${SYSDIG_CLI_VERSION} sysdig-cli-scanner:latest

# If PUSH_TO_DOCKERHUB is true, push the image to Docker Hub
if [ "${PUSH_TO_DOCKERHUB}" = "true" ]; then
    # Prompt for the Docker Hub username
    read -p "Docker Hub username: " DOCKERHUB_USERNAME
    # Prompt for the Docker Hub password
    read -s -p "Docker Hub PAT: " DOCKERHUB_PASSWORD
    echo
    # Log in to Docker Hub
    echo "${DOCKERHUB_PASSWORD}" | docker login -u "${DOCKERHUB_USERNAME}" --password-stdin
    # Tag the image with the Docker Hub username and the version number
    docker tag sysdig-cli-scanner:${SYSDIG_CLI_VERSION} ${DOCKERHUB_USERNAME}/sysdig-cli-scanner:${SYSDIG_CLI_VERSION}
    # Tag the image with the Docker Hub username and "latest"
    docker tag sysdig-cli-scanner:latest ${DOCKERHUB_USERNAME}/sysdig-cli-scanner:latest
    # Push the image tagged with the version number to Docker Hub
    docker push ${DOCKERHUB_USERNAME}/sysdig-cli-scanner:${SYSDIG_CLI_VERSION}
    # Push the image tagged with "latest" to Docker Hub
    docker push ${DOCKERHUB_USERNAME}/sysdig-cli-scanner:latest
fi

exit 0
