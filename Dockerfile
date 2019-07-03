FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
RUN git clone -b 3.3.5 git://github.com/TrinityCore/TrinityCore.git

FROM moussavdb/build-java-native as build
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
COPY --from=clone /app/TrinityCore /app
RUN make --version
RUN g++ --version
RUN cmake --version
RUN cmake .

FROM ubuntu:bionic
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
COPY --from=build /app/build /app
