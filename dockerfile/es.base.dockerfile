FROM java:openjdk-8u111-jre-alpine
MAINTAINER Eric Han <feuyeux.gmail.com>
RUN apk add --update nodejs curl
#(1/6) Installing libssh2 (1.7.0-r0)
#(2/6) Installing libcurl (7.51.0-r0)
#(3/6) Installing curl (7.51.0-r0)
#(4/6) Installing libstdc++ (5.3.0-r0)
#(5/6) Installing libuv (1.9.1-r0)
#(6/6) Installing nodejs (6.7.0-r0)