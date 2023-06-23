FROM amazonlinux:2 as installer

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && yum update -y \
    && yum install -y unzip \
    && unzip awscliv2.zip \
    && ./aws/install --bin-dir /aws-cli-bin/

# Install Snyk CLI
RUN mkdir /snyk && cd /snyk \
    && curl https://static.snyk.io/cli/v1.666.0/snyk-linux -o snyk \
    && chmod +x ./snyk

<<<<<<< Updated upstream


#FROM jenkins/jnlp-agent-python
FROM jenkins/agent
COPY --from=docker /usr/local/bin/docker /usr/local/bin/
COPY --from=installer /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=installer /aws-cli-bin/ /usr/local/bin/
COPY --from=installer /snyk/ /usr/local/bin/
COPY --from=installer /snyk/ /usr/bin/

USER root
RUN apt-get update && apt-get install -y python3 python3-pip
USER jenkins
=======
FROM docker:20.10.7-dind

COPY --from=installer /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=installer /aws-cli-bin/ /usr/local/bin/
COPY --from=installer /snyk/ /usr/local/bin/

USER root
RUN apk add --no-cache python3 python3-dev py3-pip
USER jenkins

# Optionally, you can install additional dependencies required for your pipeline
# For example, if you need Pylint and pytest, you can add the following lines:
RUN pip3 install pylint pytest
>>>>>>> Stashed changes
