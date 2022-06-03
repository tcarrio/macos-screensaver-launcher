#!/usr/bin/env sh

BASE_DIR="$(cd "$(dirname $0)"; pwd -P)"

PROJECT_NAME="Screengopher"

STATIC_DIR="${BASE_DIR}/static"

BINARY_DIR="${BASE_DIR}/bin"
BINARY_PATH="$BINARY_DIR/$PROJECT_NAME"

BUNDLE_DIR="${BASE_DIR}/pkg"

function validate_execution() {
    if [ -z "${BASE_DIR}" ]; then
        echo "BASE_DIR must be a valid string"
        exit 1
    fi
}

function build_binary() {
    if [ ! -d "${BINARY_DIR}" ]; then
        mkdir -p "${BINARY_DIR}"
    fi


    if [ -f "${BINARY_PATH}" ]; then
        rm "${BINARY_PATH}"
    fi

    go build -o "${BINARY_PATH}" main.go
}

function build_bundle() {
    if [ ! -d "${BUNDLE_DIR}" ]; then
        mkdir -p "${BUNDLE_DIR}"
    fi

    BUNDLE_NAME="${PROJECT_NAME}.app"
    BUNDLE_PATH="${BUNDLE_DIR}/${BUNDLE_NAME}"

    if [ -d "${BUNDLE_PATH}" ]; then
        rm -rf "${BUNDLE_PATH}"
    fi

    BUNDLE_CONTENTS_PATH="${BUNDLE_PATH}/Contents"

    # App metadata
    mkdir -p "${BUNDLE_CONTENTS_PATH}"

    cp "${STATIC_DIR}/Info.plist" "${BUNDLE_CONTENTS_PATH}/"

    # App executables
    mkdir -p "${BUNDLE_CONTENTS_PATH}/MacOS"

    cp "${BINARY_PATH}" "${BUNDLE_CONTENTS_PATH}/MacOS/"

    # App resources
    mkdir -p "${BUNDLE_CONTENTS_PATH}/Resources"

    cp "${STATIC_DIR}/Screengopher.icns" "${BUNDLE_CONTENTS_PATH}/Resources/"
}

### main

validate_execution
build_binary
build_bundle
