#!/usr/bin/env bash
rm -rf dist && mkdir -p dist
rm -rf binary && mkdir -p binary
cp scripts/build.sh dist/
cp amazonlinux201803/Dockerfile dist/Dockerfile
cp amazonlinux201803/.gclient dist/.gclient

export CHROMIUM_VERSION=$(scripts/latest.sh stable)
echo $CHROMIUM_VERSION
echo "building image..."
cd dist && docker build -t headless-chromium:$CHROMIUM_VERSION --build-arg VERSION="$CHROMIUM_VERSION" .

echo "extracting shell from image..."


docker run --rm --entrypoint /bin/sh headless-chromium:$CHROMIUM_VERSION -c "cat build/chromium/src/out/Headless/headless_shell" > binary/headless_shell