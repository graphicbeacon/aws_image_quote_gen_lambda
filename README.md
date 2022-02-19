# Image Quote Generator

An image quote generator written in Dart to run on AWS Lambda.

## Pre-requisites

To run the project, you need the following installed:

* [Dart](https://dart.dev/get-dart) or [Flutter](https://docs.flutter.dev/get-started/install) 
* [Docker](https://docs.docker.com/get-docker/)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

To build and deploy to your lambda function:

```shell
# Non-linux users
$ docker run -v $PWD:/app -w /app --entrypoint /app/build.sh dart:stable && \
  zip lambda.zip bootstrap && rm bootstrap

# Linux users
$ chmod +x build.sh && ./build.sh

# Update Lambda function on AWS
$ aws lambda update-function-code --function-name <function-name> --zip-file fileb://./lambda.zip
```

-> [Watch full tutorial on YouTube](https://youtube.com/CreativeBracket)