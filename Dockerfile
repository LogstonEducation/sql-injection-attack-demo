FROM alpine:3.13

WORKDIR /app

RUN apk add --no-cache \
  python3 \
  py-pip \
  uwsgi-python3

# Install reqs first to avoid rebuilds of step on each docker build call.
ADD ./requirements.txt ./requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

ENV DEBUG=false

COPY . .

CMD [ "uwsgi", "--ini", "uwsgi.ini" ]
