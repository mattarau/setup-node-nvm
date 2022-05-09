#!/bin/bash

if command -v nvm &> /dev/null; then
    echo nvm is already installed. 1>&2
    exit 0
fi

set -e
export NVM_NODEJS_ORG_MIRROR="$2"

# Clear the nvm directory
# Also sets NVM_DIR to "$HOME/.nvm" if not set.
rm -rf ${$NVM_DIR:="$HOME/.nvm"} 

git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
pushd  "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
popd
chmod +x "$NVM_DIR/nvm.sh"
. "$NVM_DIR/nvm.sh" --no-use
nvm install "$1"
echo "SETUP_NODE_NVM_NVM: $NVM_DIR/nvm.sh"
echo "SETUP_NODE_NVM_NODE: $(which node)"
echo "SETUP_NODE_NVM_NPM: $(which npm)"
