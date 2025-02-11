# this minimal dockerfile and the hello binary were copied from docker's hello-world example
# https://github.com/docker-library/hello-world
FROM scratch
COPY hello /
CMD ["/hello"]
