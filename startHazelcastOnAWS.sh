#!/bin/sh
# Performs Vagrant Up and sets environment variables

export AWS_KEY_PAIR_NAME=david
export AWS_SECURITY_GROUPS=david-us-east-1-sg

vagrant up --provider=aws