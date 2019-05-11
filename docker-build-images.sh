#!/bin/bash
docker build --target build-node -t exjobb-node .
docker build --target apache_baseline -t exjobb-baseline .
docker build --target apache_gzip -t exjobb-gzip .
docker build --target apache_minification -t exjobb-minify .
docker build --target apache_bundling -t exjobb-bundling .
docker build --target apache_tree_shaking -t exjobb-tree_shaking .
docker build --target apache_code_splitting -t exjobb-code_splitting .
docker build --target apache_all -t exjobb-all .
