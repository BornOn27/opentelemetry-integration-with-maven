
# opentelemetry-integration-with-maven

# Steps of Integration

- Create a maven spring-boot application
- Add `plugin` to download `opentelemetry-javaagent.jar`
- Add `opentelemetry` dependency to `pom.xml`
- Add `config-extension` module to manage opentelemetry configuration.
- Provide the OpenTelemetry arguments via system/environment variables
- Deploy the application

# Create a maven spring-boot application

Create any project using any IDE or [spring-initilizer](https://start.spring.io/) with following
- spring-boot - v2.5.5
- maven

Initial project structure - [Link](https://github.com/BornOn27/opentelemetry-integration-with-maven/commit/ae6e54d7e9737f2554973d414cfff5bdc4d54dec)

# Download `opentelemetry-javaagent.jar`
To download the `opentelemetry-javaagent.jar`, we will use `download-maven-plugin` in `build` stage. It will download the agent to location specified under tag `<outputDirectory>`.

To add the plugin to `build` tag in `pom.xml`, refer here - [Link](https://github.com/BornOn27/opentelemetry-integration-with-maven/blob/main/pom.xml#L38-L56)

# Add `opentelemetry` dependency

- Add `opentelemetry-api` to `pom.xml` - [Link](https://github.com/BornOn27/opentelemetry-integration-with-maven/blob/main/pom.xml#L77-L81)
- Add `opentelemetry-bom` to `pom.xml` - [Link](https://github.com/BornOn27/opentelemetry-integration-with-maven/blob/main/pom.xml#L82-L87)

# Add `config-extension` module
This module is responsible to manage the Opentelemetry configuration.
- Create `config-extension` directory to project-root.
- Add `pom.xml` with following dependencies - [Link](https://github.com/BornOn27/opentelemetry-integration-with-maven/blob/main/config-extension/pom.xml)
    - `opentelemetry-sdk-trace`
    - `opentelemetry-sdk-extension-autoconfigure-spi`
    - `opentelemetry-samplers`
- Add `Customizer.java` to exclude `health-check` from instrumentation
- Add `io.opentelemetry.sdk.autoconfigure.spi.AutoConfigurationCustomizerProvider` to specify the location of `Customizer.java`

Link for the `config-extension` module - [Link](https://github.com/BornOn27/opentelemetry-integration-with-maven/tree/main/config-extension)

# OpenTelementry Arguments
Here is the list of values we passed via system/environment variable -

- `OTEL_SERVICE_NAME=opentelemetry-integration-with-maven`
- `OPENTELEMETRY_JAEGER_SENDER_PORT=4317`
- `OTEL_PROPAGATORS=b3multi`
- `OTEL_TRACES_SAMPLER=parentbased_traceidratio`
- `OTEL_TRACES_SAMPLER_ARG=0.9`
- `OTEL_TRACES_EXPORTER=otlp`
- `OTEL_METRICS_EXPORTER=none`
- `OTEL_LOG_LEVEL=info`
- `OPENTELEMETRY_JAEGER_SENDER_HOST=8080`




# Steps of Deployment
- Download Docker
- Create Docker Image using Dockerfile
- Create Docker Container
- Run Application in Docker Container


## Download Docker
Developers love using Docker Desktop for all the best reasons: it’s easy to use, it accelerates productivity, and it eliminates the toil of setting up complex environments for building modern applications.

Download Link - [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Create Docker Image
It will use Dockerfile present in project root to create an image.

**Note - Please update the command if Dockerfile exists elsewhere.**

```  
 docker image build -t image-bornon27-maven-opentelemetry .
 ```

## Create Docker Container

Create a docker container using the image generated in previous step.
```  
docker container run --name container-bornon27-maven-opentelemetry -p 8080:8080 -d image-bornon27-maven-opentelemetry  
```  

## Run Application in Docker Container

```
docker container run --name container-bornon27-maven-opentelemetry -p 8080:8080 -d image-bornon27-maven-opentelemetry
```