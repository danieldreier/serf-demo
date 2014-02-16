#!/usr/bin/env bash

echo "First var: ${1}"

while read data; do
  echo "data = $data"
done
