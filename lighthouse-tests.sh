#!/bin/bash

echo "Running baseline"
docker run --net host --rm --name lighthouse -it -v "$(pwd)"/lighthouse-reports:/home/chrome/reports --cap-add=SYS_ADMIN femtopixel/google-lighthouse http://localhost:8080 --emulated-form-factor=desktop --preset=perf --output-path=./report_1_baseline.html

echo "Running gzip"
docker run --net host --rm --name lighthouse -it -v "$(pwd)"/lighthouse-reports:/home/chrome/reports --cap-add=SYS_ADMIN femtopixel/google-lighthouse http://localhost:8081 --emulated-form-factor=desktop --preset=perf --output-path=./report_2_gzip.html

echo "Running minify"
docker run --net host --rm --name lighthouse -it -v "$(pwd)"/lighthouse-reports:/home/chrome/reports --cap-add=SYS_ADMIN femtopixel/google-lighthouse http://localhost:8082 --emulated-form-factor=desktop --preset=perf --output-path=./report_3_minify.html

echo "Running bundling"
docker run --net host --rm --name lighthouse -it -v "$(pwd)"/lighthouse-reports:/home/chrome/reports --cap-add=SYS_ADMIN femtopixel/google-lighthouse http://localhost:8083 --emulated-form-factor=desktop --preset=perf --output-path=./report_4_bundling.html

echo "Running tree_shaking"
docker run --net host --rm --name lighthouse -it -v "$(pwd)"/lighthouse-reports:/home/chrome/reports --cap-add=SYS_ADMIN femtopixel/google-lighthouse http://localhost:8084 --emulated-form-factor=desktop --preset=perf --output-path=./report_5_tree_shaking.html

echo "Running code_splitting"
docker run --net host --rm --name lighthouse -it -v "$(pwd)"/lighthouse-reports:/home/chrome/reports --cap-add=SYS_ADMIN femtopixel/google-lighthouse http://localhost:8085 --emulated-form-factor=desktop --preset=perf --output-path=./report_6_code_splitting.html

echo "Running all"
docker run --net host --rm --name lighthouse -it -v "$(pwd)"/lighthouse-reports:/home/chrome/reports --cap-add=SYS_ADMIN femtopixel/google-lighthouse http://localhost:8086 --emulated-form-factor=desktop --preset=perf --output-path=./report_7_all.html

echo "Done with lighthouse tests."
