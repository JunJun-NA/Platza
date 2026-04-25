#!/bin/sh
#
# Configuration 名 (Debug-dev / Release-prod など) から flavor を判定し、
# 対応する GoogleService-Info.plist を Runner.app へコピーする。
# Xcode の Run Script Build Phase から実行される。

set -eu

case "$CONFIGURATION" in
  *-dev)
    FLAVOR=dev
    ;;
  *-prod)
    FLAVOR=prod
    ;;
  *)
    echo "error: unknown CONFIGURATION $CONFIGURATION" >&2
    exit 1
    ;;
esac

SOURCE="${SRCROOT}/Runner/Firebase/${FLAVOR}/GoogleService-Info.plist"
DEST="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

if [ ! -f "$SOURCE" ]; then
  echo "error: $SOURCE not found" >&2
  exit 1
fi

mkdir -p "$(dirname "$DEST")"
cp "$SOURCE" "$DEST"
echo "copied GoogleService-Info.plist for $FLAVOR"
