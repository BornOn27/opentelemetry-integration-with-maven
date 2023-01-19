# opentelemetry-integration-with-maven

# Steps of Integration


# Steps of Deployment
- Download Docker
- Create Docker Image
- Create Docker Container
- Run Application in Docker Container


## Download Docker


## Create Docker Image

```
 docker image build -t image-bornon27-maven-opentelemetry .
```

## Create Docker Container

```
docker container run --name container-bornon27-maven-opentelemetry -p 8080:8080 -d image-bornon27-maven-opentelemetry
```

## Run Application in Docker Container