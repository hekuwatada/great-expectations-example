FROM python:3.9-slim

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y -q \
    git libpq-dev python3-dev build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install --upgrade pip && \
    # version 0.15.17
    pip install great_expectations && \
    pip install sqlalchemy==1.4.25

ENV PYTHONIOENCODING=utf-8
ENV LANG C.UTF-8

ENTRYPOINT ["/usr/local/bin/great_expectations"]
CMD ["--help"]