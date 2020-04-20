#!/bin/bash
sudo apt-get update -y

## Install prerequisites
sudo apt-get install curl gnupg -y

## Install RabbitMQ signing key
curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | sudo apt-key add -

## Install apt HTTPS transport
sudo apt-get install apt-transport-https

## Add Bintray repositories that provision latest RabbitMQ and Erlang 21.x releases
sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list <<EOF
deb https://dl.bintray.com/rabbitmq-erlang/debian bionic erlang
deb https://dl.bintray.com/rabbitmq/debian bionic main
EOF

## Update package indices
sudo apt-get update -y

# ## Install rabbitmq-server and its dependencies
sudo apt-get install rabbitmq-server -y --fix-missing
sudo service rabbitmq-server stop

# Stop rabbitmq-server
sudo service rabbitmq-server stop

# Plugin install
rabbitmq-plugins --offline enable rabbitmq_peer_discovery_aws rabbitmq_management

# Config File
sudo tee /etc/rabbitmq/rabbitmq.conf <<EOF
cluster_formation.peer_discovery_backend = rabbit_peer_discovery_aws
cluster_formation.aws.region = eu-central-1

cluster_formation.aws.instance_tags.Application = rabbitmq
cluster_formation.aws.instance_tags.Environment = prod
cluster_formation.aws.instance_tags.ApplicationCategory = rabbitmq-server

cluster_formation.node_cleanup.only_log_warning = false

log.file.level = debug
EOF

echo "${RANDOM_COOKIE}" > /var/lib/rabbitmq/.erlang.cookie

rm -fr /var/lib/rabbitmq/*
rm -fr /var/log/rabbitmq/*

# Start Service
sudo service rabbitmq-server start

# Add a new admin user
# Change the value of <some-extra-secure-password>
/usr/sbin/rabbitmqctl add_user admin admin
/usr/sbin/rabbitmqctl set_user_tags admin administrator

# Setting permissions to the admin user to the two vhosts we have.
/usr/sbin/rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

# Set some policies.
/usr/sbin/rabbitmqctl set_policy -p / qml-policy ".*" '{"queue-master-locator":"random"}'

rabbitmqctl set_cluster_name ${CLUSTER_NAME}