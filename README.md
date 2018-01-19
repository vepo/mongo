# Mongo image with enabled Auth
A docker image for Mongo where the authentication can be easily configured.

# Customization
Here I describe the environment variables that you can use

- With Dockerfile
  ```
  # Auth Configuration.
  # These environment variables can also be specified through command line or docker-compose configuration
  # ENV AUTH yes

  # ENV ADMIN_USER root
  # ENV ADMIN_PASS password

  # ENV APPLICATION_DATABASE your_db
  # ENV APPLICATION_USER user
  # ENV APPLICATION_PASS password
  ```
  
- With docker-compose.yml
  ```
  services:
    db:
      image: vepo/mongo
      environment:
        - AUTH=yes
        - ADMIN_USER=admin
        - ADMIN_PASS=admin123
        - APPLICATION_DATABASE=sample
        - APPLICATION_USER=aashrey
        - APPLICATION_PASS=admin123
      ports:
        - "27017:27017"
  // more configuration
  ```

- With command line
  ```
  docker run -it \
    -e AUTH=yes \
    -e ADMIN_USER=admin \
    -e ADMIN_PASS=adminpass \
    -e APPLICATION_DATABASE=mytestdatabase \
    -e APPLICATION_USER=testuser \
    -e APPLICATION_PASS=testpass \
    -p 27017:27017 vepo/mongo
  ```

This image is based on https://github.com/aashreys/docker-mongo-auth
