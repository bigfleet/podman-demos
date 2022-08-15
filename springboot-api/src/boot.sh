#!/bin/bash
pkg=`tr '.' $'\n' <<< "$PARAM_PRIMARY_DOMAIN" | tac | paste -s -d '.'`
name=`cat $1 | jq -r .name`
defaultPackages=("oauth2-client" "actuator" "webflux" "web")

if [ `cat $1 | jq '.services | map(select(.=="mongodb")) | length'` -ge "1" ]; then
  defaultPackages+=("data-mongodb")
fi
if [ `cat $1 | jq '.services | map(select(.=="rabbitmq")) | length'` -ge "1" ]; then
  defaultPackages+=("amqp")
fi

pkgs=$(IFS=, ; echo "${defaultPackages[*]}")

url="https://start.spring.io/starter.zip?type=gradle-project&language=java&bootVersion=$PARAM_SPRINGBOOT_VERSION&groupId=$pkg&artifactId=$name&name=$name&description=Demo%20project%20for%20$name&packageName=$pkg.$name&packaging=jar&javaVersion=$PARAM_JAVA_VERSION&dependencies=$pkgs"

curl -o /home/eagle/project.zip $url
unzip /home/eagle/project.zip
rm /home/eagle/project.zip
git config --global user.email 'eagle@endava.com'
git config --global user.name  'Eagle'
git config --global init.defaultBranch main
git init
git add .
git commit -m "Initial commit"