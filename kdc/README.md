KDC 
===

## Commands

Launch container
```shell
docker run --rm -it -h kdc --name kdc hadoop-testing/kdc:${PROJECT_VERSION}
```

Login shell
```shell
docker exec -it kdc bash
```