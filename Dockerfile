# Maintainer it-ops-liron at github

FROM alpine

RUN apk add --no-cache curl python3 bash

# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz \
    && mkdir -p /usr/local/gcloud \
    && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
    && rm /tmp/google-cloud-sdk.tar.gz

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

RUN  curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

ENV DAEMON false
ENV GKE_SA /opt/sa.json

ENV GKE_REGION us-east1
ENV GKE_PROJECT project
ENV GKE_CLUSTER cluster

COPY entrypoint.sh /opt/
RUN  chmod +x /opt/entrypoint.sh 

ENTRYPOINT ["/opt/entrypoint.sh"]
