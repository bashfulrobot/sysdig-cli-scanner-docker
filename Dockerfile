FROM alpine:3.19.1
ENV SYSDIG_CLI_VERSION 1.8.5
ADD https://download.sysdig.com/scanning/bin/sysdig-cli-scanner/${SYSDIG_CLI_VERSION}/linux/amd64/sysdig-cli-scanner /sysdig-cli-scanner
RUN chmod +x /sysdig-cli-scanner
ENTRYPOINT ["/sysdig-cli-scanner"]