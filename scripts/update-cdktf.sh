#!/bin/bash
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

set -ex

PROJECT_ROOT=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)
CDKTF_VERSION=$1

if [ -z "$CDKTF_VERSION" ]; then
  echo "Usage: $0 <cdktf-version>"
  exit 1
fi

echo "Updating to cdktf version $CDKTF_VERSION"
yarn
sed -i "s/const cdktfVersion = \".*\";/const cdktfVersion = \">=$CDKTF_VERSION\";/" "$PROJECT_ROOT/.projenrc.ts"
CI=0 npx projen
