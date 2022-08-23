#!/usr/bin/env sh
set -eu

git clone https://github.com/AzureAD/microsoft-authentication-library-for-js.git "${PARAM_USER_HOME}"/msal
if [ "${PARAM_VERBOSE}" = "True" ] ; then
    set -x
fi

cp -LR "${WORKSPACE_SSH_DIRECTORY_PATH}" "${PARAM_USER_HOME}"/.ssh
chmod 700 "${PARAM_USER_HOME}"/.ssh
chmod -R 644 "${PARAM_USER_HOME}"/.ssh/*
chmod -R 400 "${PARAM_USER_HOME}"/.ssh/id_rsa

if [ "${PARAM_DEBUG}" = "true" ] ; then
    apt-get update && apt-get install -y vim && sleep infinity
fi

if [ ! -f "package-lock.json" ]
then
    cd $WORKSPACE_DIRECTORY_PATH
    echo "Configuring git"
    git config user.email 'eagle@endava.com'
    git config user.name  'Eagle'
    echo "Creating $PARAM_APP_NAME"
    ng new $PARAM_APP_NAME --defaults -g --directory .
    git add .
    git commit -am "Initializing Angular repository"
    echo "Adding MSAL sample library dependencies"
    npm i --save @azure/msal-angular @azure/msal-browser @angular/material @angular/cdk
    git add .
    git commit -am "Adding jest and test reporters"
    echo "Adding jest and test reporters"
    npm i --save-dev jest karma-coverage-istanbul-reporter
    git add .
    git commit -am "Adding jest and test reporters"
    echo "Copying example modules"
    cp -r "${PARAM_USER_HOME}"/msal/samples/msal-angular-v2-samples/angular14-rxjs7-sample-app/src/app/* ./src/app/.
    git add .
    git commit -am "Copied example modules"
    echo "Injecting OIDC configuration"
    sed -i '/PPE testing environment/d' ./src/app/app.module.ts
    sed -i "/authority/s/^\s*\/\// /g" src/app/app.module.ts
    sed -i "/clientId/s/^\s*\/\// /g" src/app/app.module.ts
    sed -i 's/6226576d-37e9-49eb-b201-ec1eeb0029b6/abadbabe000/g' src/app/app.module.ts
    git add .
    git commit -am "OIDC configuration injected"
    echo "Building"
    ng analytics disable
    npm run build
    git add .
    git commit -am "NPM buildable"
fi

EXIT_CODE="$?"
if [ "${EXIT_CODE}" != 0 ] ; then
    exit "${EXIT_CODE}"
fi
