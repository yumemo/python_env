FROM python:3.8.0-alpine3.10
LABEL Maintainer="ymmmtym"

ENV HOSTNAME="keywoo" \
    APP="/opt/keywoo" \
    PS1="[\u@\h \W]# "
ENV FLASK_APP="${APP}/run.py"
COPY [".", "${APP}"]

WORKDIR ${APP}
RUN apk updatee && \
    apk add --no-cach gcc build-base linux-headers postgresql-libs && \
    apk add --no-cach --virtual .build-deps gcc musl-dev postgresql-dev && \
    apk --purge del .build-deps && \
    rm -fr /var/cache/apk/*

RUN pip install -U pip && \
    pip install -U setuptools && \
    pip install -r requirements.txt

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.3/wait /wait
RUN chmod +x /wait

EXPOSE 5000
CMD  /bin/sh -c "/wait && ${APP}/run.sh"