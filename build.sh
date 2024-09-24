#!/bin/bash
set -eu

OS=$(uname -s)

BUILD="./.build"
DIST="./dist"

# The basename of the target executable
SEA="app"
TARGET="${DIST}/${OS}/${SEA}"

SEA_CONFIG="./sea-config.json"
BLOB="${BUILD}/sea-prep.blob"

# generate_bundler() uses webpack
WEBPACK_CONFIG="./webpack.config.js"

info() {
	echo "INFO: " "$@"
}

error() {
	echo "ERROR: " "$@"
	exit 1
}

setup() {
	info "Building ${OS} executable target"
	mkdir -p "${BUILD}"
	mkdir -p "${DIST}/${OS}"
	generate_bundle
	generate_blob
	generate_executable
}

finish() {
	info "Built executable: ${TARGET}"
}

generate_bundle() {
	npx webpack --config "${WEBPACK_CONFIG}"
}

generate_blob() {
	node --experimental-sea-config "${SEA_CONFIG}"
}

generate_executable() {
	case "${OS}" in
		Windows*) node -e "require('fs').copyFileSync(process.execPath, '${TARGET}')" ;;
		*) cp $(command -v node) "${TARGET}" ;;
	esac
}

build_sea_linux() {
	setup
	npx postject "${TARGET}" NODE_SEA_BLOB "${BLOB}" \
		--sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2
	finish
}

build_sea_darwin() {
	setup
	codesign --remove-signature "${TARGET}"
	npx postject "${TARGET}" NODE_SEA_BLOB "${BLOB}" \
		--sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 \
		--macho-segment-name NODE_SEA
	codesign --sign - "${TARGET}"
	finish
}

build_sea_windows() {
	# I don't work with Windows, so this is just an initial stab based on the following
	# link. Maybe it would work with WSL?
	# https://nodejs.org/api/single-executable-applications.html#single-executable-applications
	error "This error is to alert you that this script has not been tested for Windows and probably won't work as is"

	TARGET="${TARGET}.exe"
	setup
	signtool remove /s "{TARGET}"
	npx postject "${TARGET}" NODE_SEA_BLOB "${BLOB}" --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2
	codesign --sign - "${TARGET}"
	finish
}

case "${OS}" in
	Linux*) build_sea_linux ;;
	Darwin*) build_sea_darwin ;;
	Windows*) build_sea_windows ;;
	*) error "Unsupported OS:" "${OS}" ;;
esac
