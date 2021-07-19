FROM python:3.7-alpine
MAINTAINER mariajulia890

ENV PYTHONUNBUFFERED 1

ENV VIRTUAL_ENV=/py
RUN python3 -m venv $VIRTUAL_ENV && /py/bin/pip install --upgrade pip 
ENV PATH="$VIRTUAL_ENV/bin:$PATH"


COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev zlib zlib-dev linux-headers && \
    /py/bin/pip install -r /requirements.txt
RUN apk del .tmp-build-deps


RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user

