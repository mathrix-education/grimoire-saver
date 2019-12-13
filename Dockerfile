FROM alpine:latest

USER root
RUN apk add gzip python mysql-client
COPY ./saver_account.json /saver_account.json
COPY ./savemaker.sh /savemaker.sh
RUN wget "https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip" && \
    unzip google-cloud-sdk.zip && \
    sh ./google-cloud-sdk/install.sh --quiet && \
    source /google-cloud-sdk/path.bash.inc && \
    /google-cloud-sdk/bin/gcloud auth activate-service-account --key-file="/saver_account.json" && \
    /google-cloud-sdk/bin/gcloud auth configure-docker && \
    /google-cloud-sdk/bin/gcloud components update && \
    /google-cloud-sdk/bin/gcloud config set project mathrix-education
WORKDIR /
ENTRYPOINT ["/savemaker.sh"]

