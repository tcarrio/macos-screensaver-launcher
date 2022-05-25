#!/usr/bin/env sh

OUTPUT_DIR="./bin"
OUTPUT_FILENAME="run-screensaver"

if [ ! -d $OUTPUT_DIR ]; then
    mkdir $OUTPUT_DIR
fi

ARTIFACT_PATH="$OUTPUT_DIR/$OUTPUT_FILENAME"

if [ -f $ARTIFACT_PATH ]; then
    rm $ARTIFACT_PATH
fi

go build -o $ARTIFACT_PATH main.go
