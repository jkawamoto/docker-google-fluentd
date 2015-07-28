# Docker Google Fluentd

A Container logging other containers logs to Google Cloud Logging.

## Preparation

Build an image:

```sh
$ docker build -t jkawamoto/docker-google-fluentd .
```

or just pull the image from Docker Hub:

```sh
$ docker pull jkawamoto/docker-google-fluentd
```

## Usage
```sh
$ docker run -d --name fluentd -e "INSTANCE=some-name" \
             -v /var/lib/docker:/var/lib/docker jkawamoto/docker-google-fluentd
```
where environment variable **INSTANCE** is used to add the instance name to each log record.

### Other environment variables

#### TAG
Customizes the tag of log records
and which log those records will be stored in Google Cloud Logging.
See [API document of Google Cloud Logging](https://cloud.google.com/logging/docs/api/) for more details.

#### USERNAME
Used to add a username field to each log record.

## License
This software is released under the MIT License, see LICENSE.
