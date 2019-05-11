# exjobb-docker

## Build docker images
```
sh docker-build-images.sh
```

## Start all containers
```
docker-compose up
```

## These ports are exposed
| Container      | Port |
|----------------|------|
| baseline       | 8080 |
| gzip           | 8081 |
| minify         | 8082 |
| bundling       | 8083 |
| tree_shaking   | 8084 |
| code_splitting | 8085 |
| all            | 8086 |

## Run Lighthouse tests
```
sh lighthouse-tests.sh
```

## Lighthouse reports
Located in `lighthouse-reports`

They will be named:
```
report_1_baseline.html
report_2_gzip.html
report_3_minify.html
report_4_bundling.html
report_5_tree_shaking.html
report_6_code_splitting.html
report_7_all.html
```
