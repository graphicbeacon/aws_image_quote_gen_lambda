#!/bin/sh

export PUB_CACHE=/tmp

dart pub get
dart compile exe bin/main.dart -o bootstrap
