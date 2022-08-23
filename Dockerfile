FROM python:3.8.5

# install system packages
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y -q \
        git \ 
        libpq-dev \
        python3-dev \
        build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install --upgrade pip \
    # version 0.15.17
    && pip install great_expectations \
    && pip install sqlalchemy==1.4.25 \
    && pip install pybigquery \
    && pip install sqlalchemy_bigquery \
    && pip install black
ENV PYTHONIOENCODING=utf-8
ENV LANG C.UTF-8

# Install gcloud
RUN mkdir -p /usr/local/gcloud \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-392.0.0-linux-x86_64.tar.gz \
    && tar -C /usr/local/gcloud -xf google-cloud-cli-392.0.0-linux-x86_64.tar.gz \
    && /usr/local/gcloud/google-cloud-sdk/install.sh --quiet \
    && rm google-cloud-cli-392.0.0-linux-x86_64.tar.gz
ENV PATH=$PATH:/usr/local/gcloud/google-cloud-sdk/bin/

ENTRYPOINT ["/usr/local/bin/great_expectations"]
CMD ["--help"]